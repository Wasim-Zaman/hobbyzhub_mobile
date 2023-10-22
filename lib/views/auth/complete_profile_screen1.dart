import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class CompleteProfileScreen1 extends StatefulWidget {
  const CompleteProfileScreen1({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen1> createState() => _CompleteProfileScreen1State();
}

class _CompleteProfileScreen1State extends State<CompleteProfileScreen1> {
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.height,
                          Text('Let’s personalize your experience',
                              style: AppTextStyle.headings),
                          20.height,
                          Text(
                            'What can we call you? Could be your name, a nickname or something funny',
                            style: AppTextStyle.subHeading,
                          ),
                          20.height,
                          TextFieldWidget(
                            labelText: 'NAME',
                            controller: nameController,
                            hintText: "Enter your name",
                          ),
                          20.height,
                          TextFieldWidget(
                            labelText: 'BIO',
                            controller: nameController,
                            hintText: "Enter your bio",
                            maxLines: 5,
                          ),
                          20.height,
                          SizedBox(
                            height: context.height() * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PrimaryButtonWidget(
                                    caption: "Next",
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {}
                                    }),
                              ],
                            ),
                          ),
                          30.height,
                        ],
                      ),
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
