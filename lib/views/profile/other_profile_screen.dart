// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/bottom_sheet/bottom_sheet_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({Key? key}) : super(key: key);

  @override
  _OtherProfileScreenState createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: context.height(),
        child: Stack(
          children: [
            // Background image
            Container(
              height: context.height() * 0.50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/cover.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // Draggable content
            const DraggableBottomSheetWidget(),
          ],
        ),
      ),
    );
  }
}

class DraggableBottomSheetWidget extends StatefulWidget {
  const DraggableBottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<DraggableBottomSheetWidget> createState() =>
      _DraggableBottomSheetWidgetState();
}

class _DraggableBottomSheetWidgetState
    extends State<DraggableBottomSheetWidget> {
  double _top = 0;

  BottomSheetBloc sheetBloc = BottomSheetBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomSheetBloc, BottomSheetState>(
      bloc: sheetBloc,
      builder: (context, state) {
        return Positioned(
          left: 0,
          right: 0,
          top: state is BottomSheetDragState ? state.offset : _top,
          bottom: 0,
          child: Container(
            height: context.height() - context.height() * 0.30,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onVerticalDragUpdate: (details) {
                        _top = details.globalPosition.dy.clamp(
                          0,
                          context.height() - context.height() * 0.60,
                        );
                        sheetBloc = sheetBloc..add(BottomSheetDragEvent(_top));
                      },
                      child: Container(
                        height: 10,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.darkGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // Profile picture in circular form
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(bottom: 50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: AppColors.white,
                            ),
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/userprofile.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        10.width,
                        Text(
                          'Sara Stamp',
                          style: AppTextStyle.subHeading,
                        ),
                      ],
                    ),
                    // Bio
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'I just love the idea of not being what people expect me to be!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    20.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: PrimaryButtonWidget(
                            caption: "Follow",
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 56,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                // three dots icon
                                Ionicons.ellipsis_horizontal,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.height,
                    // Create two tabs for posts and common groups
                    // this will divide our screen in two
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        print("done");
                        return Container(
                          height: 200,
                          width: 30,
                          color: Colors.grey,
                        );
                      },
                      itemCount: 50,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                    )
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
