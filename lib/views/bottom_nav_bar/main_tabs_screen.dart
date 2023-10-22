import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/post/post_screen.dart';

class MainTabScreen extends StatefulWidget {
  final int index;

  const MainTabScreen({super.key, required this.index});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int pageIndex = 0;
  @override
  void initState() {
    pageIndex = widget.index;

    super.initState();
  }

  void selectedIndex(int index) {
    setState(() => pageIndex = index);
  }

  final pages = [
    const PostScreen(),
    const PostScreen(),
    const PostScreen(),
    const PostScreen(),
    const PostScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              ImageAssets.homeImage,
              height: 30.h,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              ImageAssets.searchImage,
              height: 30.h,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: SizedBox(
              width: 60.h,
              height: 60.h,
              child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  // context.read<NewRequestProvider>().removeAllSelectedPhotos();
                  selectedIndex(1);
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              ImageAssets.messageImage,
              height: 30.h,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Image.asset(
              ImageAssets.profileImage,
              height: 30.h,
            ),
          ),
        ],
        onTap: (value) {
          // if (value != 1) {
          selectedIndex(value);
          //}
        },
        currentIndex: pageIndex,
      ),
    );
  }
}
