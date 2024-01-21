import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/help_center/help_center_cubit.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final nameController = TextEditingController();

  final feedBackController = TextEditingController();

  // focus nodes
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final feedBackFocusNode = FocusNode();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Functions
  void submit() {
    if (formKey.currentState!.validate()) {
      context.read<HelpCenterCubit>().helpCenter(
          nameController.text.trim(), feedBackController.text.trim());
    }
  }

  @override
  void dispose() {
    nameController.dispose();

    feedBackController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    feedBackFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HelpCenterCubit, HelpCenterState>(
      listener: (context, state) {
        if (state is HelpCenterLoading) {
          FocusScope.of(context).unfocus();
          // show loading
          AppDialogs.loadingDialog(context);
        } else if (state is HelpCenterSuccess) {
          AppDialogs.closeDialog(context);
          Navigator.of(context).pop();
          toast("Request submitted successfully");
        } else if (state is HelpCenterFailed) {
          AppDialogs.closeDialog(context);

          toast("Request failed to submit");
        } else if (state is HelpCenterInternetError) {
          AppDialogs.closeDialog(context);
          toast("Internet connection failed");
        }
      },
      child: Scaffold(
        appBar: const BackAppbarWidget(title: "Help Center"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Image will come here
                  Image.asset(ImageAssets.helpDesk),
                  20.height,
                  TextFieldWidget(
                    labelText: "NAME",
                    controller: nameController,
                    focusNode: nameFocusNode,
                    hintText: "Enter your name",
                    validator: AppValidators.notEmpty,
                  ),

                  20.height,
                  TextFieldWidget(
                    labelText: "FEEDBACK",
                    controller: feedBackController,
                    hintText: "Go ahead, we are listening",
                    focusNode: feedBackFocusNode,
                    validator: AppValidators.notEmpty,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                  ),
                  20.height,
                  PrimaryButtonWidget(caption: "Submit", onPressed: submit),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
