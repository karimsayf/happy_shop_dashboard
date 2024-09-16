import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_circular_progress_indicator.dart';
import '../../../components/custom_text_filed.dart';
import '../../../components/custom_title.dart';
import '../../../utilities/colors.dart';
import '../../../utilities/validator.dart';
import '../../../view_model/auth_form_provider.dart';

class AuthForm extends StatefulWidget {
  final double width;

  const AuthForm({super.key, required this.width});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late final authFormProvider = Provider.of<AuthFormProvider>(context);


  @override
  void initState() {
    super.initState();
    final authFormProvider =
        Provider.of<AuthFormProvider>(context, listen: false);

    authFormProvider.focusNodeFirst.addListener(() {
      authFormProvider
          .updateLabelUserNameColor(authFormProvider.focusNodeFirst.hasFocus);
    });

    authFormProvider.focusNodeSecond.addListener(() {
      authFormProvider
          .updateLabelPasswordColor(authFormProvider.focusNodeSecond.hasFocus);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: authFormProvider.formKey,
      child: SizedBox(
        key: const PageStorageKey('AuthForm'),
        width: widget.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTitle(
              text: "تسجيل الدخول",
              fontSize: 27,
              fontWeight: FontWeight.w700,
              color: AppColors.c111,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              focusNode: authFormProvider.focusNodeFirst,
              hintTextDirection: TextDirection.rtl,
              hintText: 'ادخل اسم المستخدم',
              hintTextColor: AppColors.c912,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              controller: authFormProvider.usernameController,
              labelTextColor: authFormProvider.labelUserNameColor,
              focusBorderColor: AppColors.mainColor,
              generalTextFieldValidator: Validator(context).validateField,
              labelText: 'اسم المستخدم',
            ),
            const SizedBox(height: 20),
            CustomTextField(
              focusNode: authFormProvider.focusNodeSecond,
              hintTextDirection: TextDirection.rtl,
              hintText: 'ادخل الرقم السري',
              hintTextColor: AppColors.c912,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              controller: authFormProvider.passwordController,
              labelTextColor: authFormProvider.labelPasswordColor,
              focusBorderColor: AppColors.mainColor,
              generalTextFieldValidator: Validator(context).validateField,
              obscureText: authFormProvider.isPasswordVisible,
              maxLines: 1,
              labelText: 'الرقم السري',
              suffixIcon: IconButton(
                onPressed: authFormProvider.togglePasswordVisibility,
                icon: Image.asset(
                  authFormProvider.isPasswordVisible
                      ? "assets/icons/eye_splash.webp"
                      : "assets/icons/eye.webp",
                  scale: 3.5,
                ),
              ),
              onFieldSubmitted: (val) async {
                await Provider.of<AuthFormProvider>(context,listen: false).signIn(
                    context,
                    authFormProvider.usernameController.text.trim(),
                    authFormProvider.passwordController.text.trim());
              },
            ),
            /*const SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                  value: authFormProvider.isChecked,
                  onChanged: (bool? value) {
                    authFormProvider.setChecked(value!);
                  },
                  activeColor: AppColors.mainColor,
                  checkColor: AppColors.c555,
                  side: const BorderSide(color: AppColors.mainColor, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                const SizedBox(width: 5),
                const CustomTitle(
                  text: "تذكرني",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.c111,
                ),
              ],
            ),*/
            Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 30, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.mainColor,
              ),
              child: InkWell(
                onTap: authFormProvider.isLoading
                    ? () {}
                    : () async {
                        await Provider.of<AuthFormProvider>(context,listen: false).signIn(
                          context,
                            authFormProvider.usernameController.text.trim(),
                            authFormProvider.passwordController.text.trim());
                      },
                borderRadius: BorderRadius.circular(14),
                child: Center(
                  child: authFormProvider.isLoading
                      ? const CustomCircularProgressIndicator(
                          iosSize: 30, color: AppColors.c555)
                      : const CustomTitle(
                          text: "تسجل الدخول",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.c555,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
