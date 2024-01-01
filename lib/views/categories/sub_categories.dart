// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/categories/sub_categories_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/auth/finish_account_model.dart';
import 'package:hobbyzhub/models/category/category_model.dart';
import 'package:hobbyzhub/models/category/sub_category_model.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/bottom_nav_bar/main_tabs_screen.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

// global variables
List<SubCategoryModel> selectedSubCategories = [];

class SubCategoryScreen extends StatefulWidget {
  final List<CategoryModel> selectedCategories;
  final FinishAccountModel model;
  const SubCategoryScreen({
    Key? key,
    required this.selectedCategories,
    required this.model,
  }) : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  // Lists
  late List<List<SubCategoryModel>> subCategories;
  late List<Map<String, dynamic>> _subCategories;

  // Blocs
  late SubCategoriesBloc subCategoriesBloc;

  @override
  void initState() {
    _subCategories = List.generate(
      widget.selectedCategories.length,
      (index) => {
        widget.selectedCategories[index].categoryName!: [],
        "iconLink": widget.selectedCategories[index].iconLink!,
      },
    );
    initBlocs();
    super.initState();
  }

  initBlocs() {
    subCategoriesBloc = SubCategoriesBloc();
    // call the bloc index wise
    for (int i = 0; i < widget.selectedCategories.length; i++) {
      subCategoriesBloc = subCategoriesBloc
        ..add(SubCategoriesFetchInitialEvent(
          categoryId: widget.selectedCategories[i].categoryId!,
          categoryName: widget.selectedCategories[i].categoryName!,
          index: i,
        ));
    }
  }

  Future subscribeUser() async {
    // subscribe user to the selected sub categories
    for (int i = 0; i < selectedSubCategories.length; i++) {
      subCategoriesBloc = subCategoriesBloc
        ..add(SubCategoriesSubscribeEvent(
          subCategoryId: selectedSubCategories[i].categoryId!,
          finishAccountModel: widget.model,
        ));
    }
  }

  @override
  void dispose() {
    subCategoriesBloc.close();

    selectedSubCategories.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCategoriesBloc, SubCategoriesState>(
      bloc: subCategoriesBloc,
      listener: (context, state) {
        if (state is SubCategoriesLoadedState) {
          // store the sub categories index wise
          _subCategories[state.index][state.categoryName] =
              state.subCategories.data;
        } else if (state is SubCategoriesSubscribedState) {
          AppNavigator.goToPageWithReplacement(
            context: context,
            screen: MainTabScreen(index: 0),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: ShapeDecoration(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.w, color: Color(0x33A0A2B3)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  width: 30.w,
                  height: 30.h,
                  child: Center(
                    child: Icon(Icons.navigate_before, size: 30.sp),
                  ),
                ),
              ),
            ),
            title: Center(
              child: Text('Sub-categories', style: AppTextStyle.headings),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Icon(Icons.search, size: 30.sp),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: _subCategories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        // shadows: [
                        //   BoxShadow(
                        //     color: Color(0x26000000),
                        //     blurRadius: 15,
                        //     offset: Offset(0, 4),
                        //     spreadRadius: 0,
                        //   )
                        // ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: _subCategories[index]["iconLink"],
                                height: 45.w,
                                width: 45.w,
                                placeholder: (context, url) => LoadingWidget(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.image_outlined,
                                  size: 40.sp,
                                  color: AppColors.black,
                                ),
                              ),
                              20.width,
                              Text(
                                _subCategories[index].keys.first,
                                style: AppTextStyle.subHeading,
                              )
                            ],
                          ),
                          10.height,
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: List.generate(
                              _subCategories[index].values.first.length,
                              (i) => SubCategoryWidget(
                                model: _subCategories[index].values.first[i],
                              ),
                            ),
                          )
                        ],
                      ).paddingAll(16.w),
                    ),
                  );
                },
              )),
              20.height,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PrimaryButtonWidget(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    onPressed: subscribeUser,
                    caption: 'Finish Registration',
                  ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // Text('Skip for now',
                  //     textAlign: TextAlign.center, style: AppTextStyle.subHeading)
                ],
              ),
              20.height,
            ],
          ).paddingAll(8),
        );
      },
    );
  }
}

class SubCategoryWidget extends StatefulWidget {
  final SubCategoryModel model;
  const SubCategoryWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          if (isSelected) {
            selectedSubCategories.add(widget.model);
          } else {
            selectedSubCategories.remove(widget.model);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
            side: BorderSide(
              color: isSelected ? AppColors.primary : AppColors.darkGrey,
              width: 1.w,
            ),
          ),
        ),
        margin: EdgeInsets.all(6),
        child: Text(
          widget.model.categoryName!,
          textAlign: TextAlign.center,
          style: AppTextStyle.subcategorySelectedTextStyle.copyWith(
            color: isSelected ? AppColors.white : AppColors.darkGrey,
          ),
        ),
      ),
    );
  }
}
