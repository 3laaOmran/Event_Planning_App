import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/home/home_screen/home_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:evently_app/utils/helpers/cash_helper.dart';
import 'package:evently_app/utils/models/user_model.dart';
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

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isObscure = true;
  bool isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
    // var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDark()
            ? AppColors.primaryDark
            : AppColors.whiteColor,
        title: Text(
          AppLocalizations.of(context)!.register,
          style: themeProvider.isDark()
              ? TextStyles.regular22primaryLight
              : TextStyles.regular22black,
        ),
        centerTitle: true,
        toolbarHeight: height * 0.1,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(AssetsManager.eventlyLogo),
                SizedBox(height: height * 0.05),
                CustomTextFormField(
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!.name_validation;
                    }
                    return null;
                  },
                  controller: nameController,
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      AssetsManager.nameIcon,
                    ),
                  ),
                  hintText: AppLocalizations.of(context)!.name,
                ),
                SizedBox(height: height * 0.015),
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
                  isObscure: isObscure,
                  controller: passwordController,
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      AssetsManager.passwordIcon,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        isObscure = !isObscure;
                        setState(() {});
                      },
                      child: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility)),
                  hintText: AppLocalizations.of(context)!.password,
                ),
                SizedBox(height: height * 0.015),
                CustomTextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return AppLocalizations.of(context)!
                          .rePassword_validation;
                    }
                    if (value != passwordController.text) {
                      return AppLocalizations.of(context)!
                          .rePassword_format_validation;
                    }
                    return null;
                  },
                  isObscure: isObscure2,
                  controller: rePasswordController,
                  prefixIcon: const ImageIcon(
                    AssetImage(
                      AssetsManager.passwordIcon,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        isObscure2 = !isObscure2;
                        setState(() {});
                      },
                      child: Icon(isObscure2
                          ? Icons.visibility_off
                          : Icons.visibility)),
                  hintText: AppLocalizations.of(context)!.re_password,
                ),
                SizedBox(height: height * 0.02),
                CustomElevatedButton(
                    bgColor: AppColors.primaryLight,
                    buttonText: Text(
                      AppLocalizations.of(context)!.create_account,
                      style: TextStyles.medium20White,
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        CustomDialog.showLoading(
                            bgColor: themeProvider.isDark()
                                ? AppColors.primaryDark
                                : AppColors.whiteColor,
                            context: context,
                            message: AppLocalizations.of(context)!.loading);
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          UserModel user = UserModel(
                            id: credential.user?.uid ?? '',
                            name: nameController.text,
                            email: emailController.text,
                          );
                          await FirebaseUtils.addUserToFireStore(user);
                          // userProvider.updateUser(user);
                          CashHelper.saveData(key: 'uId', value: user.id);
                          CashHelper.saveData(key: 'uName', value: user.name);
                          CashHelper.saveData(key: 'uEmail', value: user.email);
                          CustomDialog.hideLoading(context);
                          CustomDialog.showAlert(
                              context: context,
                              bgColor: themeProvider.isDark()
                                  ? AppColors.primaryDark
                                  : AppColors.whiteColor,
                              title: AppLocalizations.of(context)!.success,
                              message: AppLocalizations.of(context)!
                                  .register_successfully,
                              posActionName: AppLocalizations.of(context)!.ok,
                              posAction: () {
                                Navigator.pushReplacementNamed(
                                    context, HomeScreen.routeName);
                              });
                        } catch (e) {
                          CustomDialog.hideLoading(context);
                          CustomDialog.showAlert(
                            context: context,
                            bgColor: themeProvider.isDark()
                                ? AppColors.primaryDark
                                : AppColors.whiteColor,
                            title: AppLocalizations.of(context)!.error,
                            message:
                                AppLocalizations.of(context)!.register_error,
                            posActionName: AppLocalizations.of(context)!.ok,
                          );
                        }
                      }
                    }),
                SizedBox(height: height * 0.02),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.already_have_account,
                    style: themeProvider.isDark()
                        ? TextStyles.medium16White
                        : TextStyles.medium16black,
                  ),
                  TextSpan(
                      text: AppLocalizations.of(context)!.login,
                      style: TextStyles.bold16PrimaryLightItalic,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        }),
                ])),
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
