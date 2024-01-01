// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/categories/categories_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/auth/finish_account_model.dart';
import 'package:hobbyzhub/models/category/category_model.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/categories/sub_categories.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class MainCategoriesScreen extends StatefulWidget {
  final FinishAccountModel model;
  const MainCategoriesScreen({Key? key, required this.model}) : super(key: key);

  @override
  _MainCategoriesScreenState createState() => _MainCategoriesScreenState();
}

class _MainCategoriesScreenState extends State<MainCategoriesScreen> {
  //Blocs
  late CategoriesBloc categoriesBloc;

  // Lists
  List<CategoryModel> categories = [];
  List<CategoryModel> selectedCategories = [];

  // Flags
  bool _isSearching = false;

  @override
  void initState() {
    initBlocs();
    getInitialCategories();
    super.initState();
  }

  initBlocs() {
    categoriesBloc = CategoriesBloc();
  }

  @override
  void dispose() {
    categoriesBloc.close();
    super.dispose();
  }

  getInitialCategories() {
    categoriesBloc = categoriesBloc..add(CategoriesFetchInitialEvent());
  }

  Widget _buildSearchField() {
    return Visibility(
      visible: _isSearching,
      child: AnimatedCrossFade(
        duration: Duration(milliseconds: 800),
        firstChild: IconButton(
          icon: Image.asset(ImageAssets.searchImage, height: 30, width: 30),
          onPressed: () {
            setState(() {
              _isSearching = false;
            });
          },
        ),
        secondChild: SizedBox(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              prefixIcon: Image.asset(ImageAssets.searchImage),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (term) {
              // Perform search based on the entered query
              // You can update your search results or filter data accordingly
            },
          ),
        ),
        crossFadeState:
            _isSearching ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0x33A0A2B3)),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            width: 30.w,
            height: 30.h,
            child: Center(
              child: Icon(
                Icons.navigate_before,
                size: 30.sp,
              ),
            ),
          ),
        ),
        title: _isSearching ? _buildSearchField() : null,
        actions: [
          IconButton(
            icon: _isSearching
                ? Icon(Icons.cancel_rounded, size: 30)
                : Image.asset(
                    ImageAssets.searchImage,
                    height: 30,
                    width: 30,
                  ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
          ),
        ],
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.all(8.w),
        //     child: Icon(
        //       Icons.search,
        //       size: 30.sp,
        //     ),
        //   ),
        // ],
      ),
      body: BlocConsumer<CategoriesBloc, CategoriesState>(
        bloc: categoriesBloc,
        listener: (context, state) {
          if (state is CategoriesLoadingState) {
            categories.clear();
          } else if (state is CategoriesLoadedState) {
            categories = state.categories.data;
          }
        },
        builder: (context, state) {
          if (state is CategoriesLoadingState) {
            return Center(child: LoadingWidget());
          } else if (state is CategoriesErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.error),
                  20.height,
                  PrimaryButtonWidget(
                    onPressed: getInitialCategories,
                    caption: "Reload",
                    height: 40,
                    width: 200,
                  ),
                ],
              ),
            );
          } else if (state is CategoriesEmptyState) {
            return Center(
              child: Text("No Categories Found"),
            );
          }
          return Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                Text('Hobby Categories', style: AppTextStyle.headings),
                15.height,
                Text(
                    'Select your hobby category to find and connect with people of similar interest',
                    style: AppTextStyle.subHeading),
                20.height,
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemCount: categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // add category into the selected category list
                          setState(() {
                            // if category is already there, remove it
                            // otherwise add it to selected categories list
                            if (selectedCategories
                                .contains(categories[index])) {
                              selectedCategories.remove(categories[index]);
                            } else {
                              selectedCategories.add(categories[index]);
                            }
                          });
                        },
                        child: Container(
                          width: 80.w,
                          height: 97.h,
                          padding: EdgeInsets.all(5.w),
                          decoration: ShapeDecoration(
                            color:
                                selectedCategories.contains(categories[index])
                                    ? AppColors.primary.withOpacity(0.3)
                                    : AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 7,
                                offset: Offset(0, 0),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: categories[index].iconLink.toString(),
                                height: 40.h,
                                placeholder: (context, url) => LoadingWidget(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image_outlined,
                                  size: 40.sp,
                                  color: selectedCategories
                                          .contains(categories[index])
                                      ? AppColors.white
                                      : AppColors.black,
                                ),
                              ),
                              10.height,
                              Text(
                                categories[index].categoryName.toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                20.height,
                PrimaryButtonWidget(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  onPressed: () {
                    AppNavigator.goToPage(
                      context: context,
                      screen: SubCategoryScreen(
                        selectedCategories: selectedCategories,
                        model: widget.model,
                      ),
                    );
                  },
                  caption: 'Next',
                ),
                20.height,
              ],
            ).paddingAll(9.w),
          );
        },
      ),
    );
  }
}
