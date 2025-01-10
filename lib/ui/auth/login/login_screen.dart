import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/auth/forget_password/forget_password_screen.dart';
import 'package:evently_app/ui/auth/register/register_screen.dart';
import 'package:evently_app/ui/home/home_screen/home_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_dialog.dart';
import 'package:evently_app/utils/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/widgets/switch_language_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: '3laa@gmail.com');
  var passwordController = TextEditingController(text: '1234567');
  var formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: height * 0.1),
                Image.asset(AssetsManager.eventlyLogo),
                SizedBox(height: height * 0.05),
                CustomTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.email_validation;
                    }
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return AppLocalizations.of(context)!
                          .email_format_validation;
                    }
                    return null;
                  },
                  controller: emailController,
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      AssetsManager.emailIcon,
                    ),
                  ),
                  hintText: AppLocalizations.of(context)!.email,
                ),
                SizedBox(height: height * 0.015),
                CustomTextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.password_validation;
                    }
                    if (value.length <= 6) {
                      return AppLocalizations.of(context)!
                          .password_format_validation;
                    }
                    return null;
                  },
                  controller: passwordController,
                  isObscure: isObscure,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        isObscure = !isObscure;
                        setState(() {});
                      },
                      child: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility)),
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      AssetsManager.passwordIcon,
                    ),
                  ),
                  hintText: AppLocalizations.of(context)!.password,
                ),
                Align(
                  alignment: languageProvider.appLanguage == 'en'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ForgetPasswordScreen.routeName);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.forget_password,
                      style: TextStyles.bold16PrimaryLightItalic.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                CustomElevatedButton(
                    bgColor: AppColors.primaryLight,
                    buttonText: Text(
                      AppLocalizations.of(context)!.login,
                      style: TextStyles.medium20White,
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        CustomDialog.showLoading(
                            context: context,
                            message: AppLocalizations.of(context)!.loading);
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          var user = await FirebaseUtils.readUserFromFireStore(
                              credential.user?.uid ?? '');
                          if (user == null) {
                            return;
                          }
                          userProvider.updateUser(user);
                          CustomDialog.hideLoading(context);
                          CustomDialog.showAlert(
                              context: context,
                              bgColor: themeProvider.isDark()
                                  ? AppColors.primaryDark
                                  : AppColors.whiteColor,
                              title: AppLocalizations.of(context)!.success,
                              message: AppLocalizations.of(context)!
                                  .login_successfully,
                              posActionName: AppLocalizations.of(context)!.ok,
                              posAction: () {
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.routeName);
                              });

                          print('Login Successfully');
                          print('User ID : ${credential.user!.uid}');
                        } catch (e) {
                          CustomDialog.hideLoading(context);
                          CustomDialog.showAlert(
                            context: context,
                            bgColor: themeProvider.isDark()
                                ? AppColors.primaryDark
                                : AppColors.whiteColor,
                            title: AppLocalizations.of(context)!.error,
                            message: AppLocalizations.of(context)!
                                .email_and_password_wrong,
                            posActionName: AppLocalizations.of(context)!.ok,
                          );
                          print('Error Ya 3L2');
                        }
                      }
                    }),
                SizedBox(height: height * 0.02),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.do_not_have_account,
                    style: themeProvider.isDark()
                        ? TextStyles.medium16White
                        : TextStyles.medium16black,
                  ),
                  TextSpan(
                      text: AppLocalizations.of(context)!.create_account,
                      style: TextStyles.bold16PrimaryLightItalic.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryLight,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        }),
                ])),
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        endIndent: 16,
                        indent: 26,
                        thickness: 1,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.or,
                      style: TextStyles.medium16primaryLight,
                    ),
                    const Expanded(
                      child: Divider(
                        endIndent: 26,
                        indent: 16,
                        thickness: 1,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                    bgColor: AppColors.transparent,
                    buttonText: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsManager.googleIcon),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Text(
                          AppLocalizations.of(context)!.login_with_google,
                          style: TextStyles.medium20primaryLight,
                        ),
                      ],
                    ),
                    onPressed: () {}),
                SizedBox(height: height * 0.02),
                const SwitchLanguageButton(),
                SizedBox(height: height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
