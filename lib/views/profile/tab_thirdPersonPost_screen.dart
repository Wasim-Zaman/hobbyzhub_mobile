import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/third_user_post/third_user_post_cubit.dart';

class TabThirdPersonPostScreen extends StatefulWidget {
  final String userId;

  TabThirdPersonPostScreen({required this.userId});

  @override
  State<TabThirdPersonPostScreen> createState() =>
      _TabThirdPersonPostScreenState();
}

class _TabThirdPersonPostScreenState extends State<TabThirdPersonPostScreen> {
  late ThirdUserCubit thirdUserCubit;

  initCubit() async {
    thirdUserCubit = context.read<ThirdUserCubit>();
    thirdUserCubit.getPosts(widget.userId);
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdUserCubit, ThirdUserState>(
      builder: (context, state) {
        if (state is ThirdUserLoaded) {
          return GridView.builder(
              itemCount: state.thirdUserPost.first.data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state
                          .thirdUserPost.first.data[index].imageUrls.length,
                      itemBuilder: ((context, _index) {
                        return Stack(
                          children: [
                            CachedNetworkImage(
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                imageUrl: state.thirdUserPost.first.data[index]
                                    .imageUrls[_index]),
                            state.thirdUserPost.first.data[index].imageUrls
                                        .length >
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
        } else if (state is ThirdUserFailed) {
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
