import 'dart:developer' as dev;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';
import 'package:hobbyzhub/blocs/chat/private/private_chat_cubit.dart';
import 'package:hobbyzhub/blocs/user/user_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/messaging/private_messaging_screen.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String? userId;

  // Blocs
  UserBloc userBloc = UserBloc();
  late ChatBloc chatBloc;

  // Lists
  List<User> searchedUsers = [];
  List<PrivateChat> chats = [];

  // Controllers
  ScrollController searchedUserController = ScrollController();
  ScrollController chatController = ScrollController();

  // Pagination
  int page = 0;
  int pageSize = 20;

  int chatPage = 0;
  int chatPageSize = 20;

  // Others
  String slug = '';

  @override
  void initState() {
    UserSecureStorage.fetchUserId().then((id) {
      setState(() {
        userId = id;
      });
    });
    searchedUserController.addListener(() {
      // when we scroll all users then increase the page size by 1 and call searchMoreUser function
      if (searchedUserController.position.pixels ==
          searchedUserController.position.maxScrollExtent) {
        page = page + 1;
        searchUserMore();
      }
    });
    super.initState();
  }

  searchUserInit() {
    slug = '';
    userBloc.add(
      UserSearchByNameEvent(slug: slug, page: page, pageSize: pageSize),
    );
  }

  searchUserMore() {
    userBloc.add(
      UserSearchByNameMoreEvent(slug: slug, page: page, pageSize: pageSize),
    );
  }

  void showUsersSheet(context) {
    searchUserInit();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        useSafeArea: true,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.6,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 25.h,
                    child: TextField(
                      onChanged: (value) {
                        slug = value;
                        searchUserInit();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        hintText: "Search",
                        hintStyle: AppTextStyle.listTileSubHeading,
                        prefixIcon: Image.asset(
                          ImageAssets.searchImage,
                          height: 10.h,
                          width: 10.w,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: BlocConsumer<UserBloc, UserState>(
                    bloc: userBloc,
                    listener: (context, state) {
                      if (state is UserSearchByNameLoading) {
                        searchedUsers.clear();
                      } else if (state is UserSearchByNameSuccess) {
                        searchedUsers = state.users;
                      } else if (state is UserSearchByNameMoreSuccess) {
                        searchedUsers.addAll(state.users);
                      }
                    },
                    builder: (context, state) {
                      if (state is UserSearchByNameLoading) {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      } else if (state is UserSearchByNameFailure) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      return ListView.builder(
                          controller: searchedUserController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: searchedUsers.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {},
                              leading: SizedBox(
                                width: 45.w,
                                height: 45.h,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 45.w,
                                      height: 45.h,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              searchedUsers[index]
                                                  .profileImage
                                                  .toString(),
                                              errorListener: (_) {
                                            print("error");
                                          }),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   left: 35,
                                    //   top: 36,
                                    //   child: Container(
                                    //     width: 12,
                                    //     height: 12,
                                    //     decoration: ShapeDecoration(
                                    //       color: Color(0xFF12B669),
                                    //       shape: OvalBorder(),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              title: Text(
                                searchedUsers[index].fullName.toString(),
                                style: AppTextStyle.listTileTitle,
                              ),
                              // subtitle: Text(
                              //   'Last Active 3 hours',
                              //   style: AppTextStyle.listTileSubHeading,
                              // ),
                              trailing: TextButton(
                                onPressed: () {
                                  ChatCubit.get(context).createPrivateChat(
                                    searchedUsers[index].userId.toString(),
                                  );
                                },
                                child: const Text('Start Chat'),
                              ),
                            ).visible(searchedUsers[index].userId != userId);
                          });
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Chat", style: AppTextStyle.headings),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  showUsersSheet(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Image.asset(
                    ImageAssets.addNewMessageImage,
                    height: 25.h,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: userId == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : BlocListener<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatCreatePrivateLoading) {
                  AppDialogs.loadingDialog(context);
                } else if (state is ChatCreatePrivateSuccess) {
                  AppDialogs.closeDialog(context);

                  AppNavigator.goToPage(
                      context: context,
                      screen: PrivateMessagingScreen(
                        chat: state.chat,
                        userId: userId.toString(),
                      ));
                } else if (state is ChatCreatePrivateError) {
                  AppDialogs.closeDialog(context);
                  dev.log(state.message);
                  toast(state.message);
                }
              },
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('private-chats')
                    .where('type', isEqualTo: 'PRIVATE')
                    .where('participantIds', arrayContains: userId.toString())
                    // .orderBy('lastMessage.timestamp', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var docs = snapshot.data!.docs;
                  var _chats = snapshot.data!.docs
                      .map((doc) => PrivateChat.fromJson(doc.data()))
                      .toList();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "All Messages",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _chats.length,
                            itemBuilder: (ctx, index) {
                              var record = _chats[index].participants;
                              var user = record?.firstWhere(
                                  (element) => element.userId != userId,
                                  orElse: () => Participants());
                              return GestureDetector(
                                onTap: () {
                                  // convert the snapshot into a private chat model
                                  var chat = PrivateChat.fromJson(
                                    docs[index].data(),
                                  );

                                  AppNavigator.goToPage(
                                    context: context,
                                    screen: PrivateMessagingScreen(
                                      chat: chat,
                                      userId: userId.toString(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                          user!.profileImage.toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(user.fullName.toString()),
                                            Text(_chats[index]
                                                .lastMessage
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   DateTime.parse(chats[index]['lastMessage']
                                          //               ['timestamp']
                                          //           .toDate()
                                          //           .toString())
                                          //       .timeAgo,
                                          //   style: TextStyle(
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                          const SizedBox(height: 10),
                                          // timestamp
                                          if (_chats[index].unread != null)
                                            Badge(
                                              label: Text(
                                                docs[index]['unread']['$userId']
                                                    .toString(),
                                              ),
                                              backgroundColor:
                                                  AppColors.primary,
                                            ).visible(
                                              docs[index]['unread']
                                                          ['$userId'] !=
                                                      0 ||
                                                  docs[index]['unread'] != null,
                                            ),
                                        ],
                                      )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
