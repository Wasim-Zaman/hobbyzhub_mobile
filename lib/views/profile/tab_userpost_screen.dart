import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/user_posts/user_post_cubit.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class TabPostScreen extends StatefulWidget {
  const TabPostScreen({super.key});

  @override
  State<TabPostScreen> createState() => _TabPostScreenState();
}

class _TabPostScreenState extends State<TabPostScreen> {
  late UserPostCubit userPostCubit;

  initCubit() async {
    final userId = await UserSecureStorage.fetchUserId();

    userPostCubit = context.read<UserPostCubit>();
    userPostCubit.getPosts(userId);
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPostCubit, UserPostState>(
      builder: (context, state) {
        if (state is UserPostLoaded) {
          return GridView.builder(
              itemCount: state.userPost.first.data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          state.userPost.first.data[index].imageUrls.length,
                      itemBuilder: ((context, _index) {
                        return Stack(
                          children: [
                            CachedNetworkImage(
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                imageUrl: state.userPost.first.data[index]
                                    .imageUrls[_index]),
                            state.userPost.first.data[index].imageUrls.length >
                                    1
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                        size: 15.sp,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        );
                      })),
                );
              }));
        } else if (state is UserPostFailed) {
          return SizedBox(
            child: Text('Post not found'),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
