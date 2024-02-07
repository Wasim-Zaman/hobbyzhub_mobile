// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';
import 'package:hobbyzhub/blocs/user/user_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/chat_model.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_date.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/app_toast.dart';
import 'package:hobbyzhub/views/messaging/messaging_screen.dart';
import 'package:hobbyzhub/views/widgets/images/image_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Blocs
  UserBloc userBloc = UserBloc();
  late ChatBloc chatBloc;

  // Lists
  List<User> searchedUsers = [];
  List<ChatModel> chats = [];

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
    initBlocs();
    searchedUserController.addListener(() {
      // when we scroll all users then increase the page size by 1 and call searchMoreUser function
      if (searchedUserController.position.pixels ==
          searchedUserController.position.maxScrollExtent) {
        page = page + 1;
        searchUserMore();
      }
    });
    chatController.addListener(() {
      // when we scroll all users then increase the page size by 1 and call searchMoreUser function
      if (chatController.position.pixels ==
          chatController.position.maxScrollExtent) {
        chatPage = chatPage + 1;
        getMoreChats();
      }
    });
    super.initState();
  }

  initBlocs() {
    chatBloc = context.read<ChatBloc>();
  }

  getMoreChats() {}

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

  @override
  void dispose() {
    userBloc.close();
    chatBloc.close();
    searchedUserController.dispose();
    super.dispose();
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
                  _searchBottomSheet(context);
                },
                child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      ImageAssets.searchImage,
                      height: 25.h,
                    )),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      ImageAssets.addNewMessageImage,
                      height: 25.h,
                    )),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Frequently Chatted',
              style: AppTextStyle.exploreSubHead,
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 70.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 50.w,
                          //  height: 51.h,
                          child: Stack(
                            children: [
                              Container(
                                width: 49.w,
                                height: 60.h,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r)),
                                ),
                              ),
                              Positioned(
                                left: 40.w,
                                top: 50.h,
                                child: Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF12B669),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    );
                  }),
            ),
            10.height,
            Text(
              'All Messages',
              style: AppTextStyle.exploreSubHead,
            ),
            20.height,
            BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatGetSuccessState) {
                  chats = state.chats;
                } else if (state is ChatCreatePrivateSuccessState) {
                  Navigator.pop(context);
                  AppNavigator.goToPage(
                    context: context,
                    screen: MessagingScreen(
                      chat: state.chat,
                    ),
                  );
                } else if (state is ChatCreatePrivateErrorState) {
                  Navigator.pop(context);
                  AppToast.danger(state.message);
                }
              },
              builder: (context, state) {
                if (state is ChatLoadingState) {
                  // show shimmer effect while loading
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return PrivateChatTileShimmer();
                        }),
                  );
                } else if (state is ChatErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        if (chats[index].type == 'private') {
                          return PrivateChatTile(chat: chats[index]);
                        }
                        return null;
                      }),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _searchBottomSheet(context) {
    searchUserInit();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        useSafeArea: true,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.6,
            decoration: BoxDecoration(
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
                        contentPadding: EdgeInsets.all(0),
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
                Divider(),
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UserSearchByNameFailure) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      return ListView.builder(
                          controller: searchedUserController,
                          physics: AlwaysScrollableScrollPhysics(),
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
                                          image: NetworkImage(
                                            searchedUsers[index]
                                                .profileImage
                                                .toString(),
                                          ),
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
                                  chatBloc.add(
                                    ChatCreateNewPrivateCatEvent(
                                      otherUserId: searchedUsers[index]
                                          .userId
                                          .toString(),
                                    ),
                                  );
                                },
                                child: Text('Start Chat'),
                              ),
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}

class PrivateChatTile extends StatefulWidget {
  final ChatModel chat;
  const PrivateChatTile({Key? key, required this.chat}) : super(key: key);

  @override
  State<PrivateChatTile> createState() => _PrivateChatTileState();
}

class _PrivateChatTileState extends State<PrivateChatTile> {
  MessageModel? lastMessage;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(
          ChatGetLocalMessagesEvent(chatId: widget.chat.chatId.toString()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatGetLocalMessagesSuccessState) {
          lastMessage = state.messages.last;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            AppNavigator.goToPage(
              context: context,
              screen: MessagingScreen(chat: widget.chat),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              color: AppColors.lightGrey,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20.h, bottom: 20.h, left: 5.w, right: 5.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10.h,
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              ImageWidget(
                                imageUrl: widget.chat.chatParticipants![0]
                                        .profileImage ??
                                    "",
                                width: 45.w,
                                height: 45.h,
                                errorWidget: Image.asset(
                                  ImageAssets.profileImage,
                                ),
                              ),
                              Positioned(
                                left: 35.w,
                                top: 33.h,
                                child: Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF12B669),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.chat.chatParticipants![0].fullName!,
                                style: AppTextStyle.listTileTitle,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              SizedBox(
                                width: 250.w,
                                child: Text(
                                  lastMessage != null
                                      ? lastMessage!.messageString!
                                      : '',
                                  maxLines: 2,
                                  style: AppTextStyle.listTileSubHeading,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppDate.parseTimeStringToDateTime(
                                        widget.chat.dateTimeCreated!)
                                    .timeAgo,
                                style: AppTextStyle.likeByTextStyle,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: ShapeDecoration(
                                  color: AppColors.primary,
                                  shape: OvalBorder(),
                                ),
                                child: Center(
                                  child: Text(
                                    '',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle
                                        .subcategorySelectedTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PrivateChatTileShimmer extends StatelessWidget {
  const PrivateChatTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Padding(
            padding:
                EdgeInsets.only(top: 20.h, bottom: 20.h, left: 5.w, right: 5.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10.h,
                    ),
                    Expanded(
                      child: Container(
                        width: 45.w,
                        height: 45.h,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 10.h,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            width: 250.w,
                            height: 10.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 10.h,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: 20.w,
                            height: 20.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
