import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/auth/register/register_navigator.dart';
import 'package:evently_app/ui/auth/register/register_screen_view_model.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_dialog.dart';
import 'package:evently_app/utils/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/widgets/switch_language_button.dart';
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

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  bool isObscure = true;
  bool isObscure2 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.registerNavigator = this;
  }

  var themeProvider;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    themeProvider = Provider.of<ThemeProvider>(context);
    // var userProvider = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
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
              key: viewModel.formKey,
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
                    controller: viewModel.nameController,
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
                    controller: viewModel.emailController,
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
                        return AppLocalizations.of(context)!
                            .password_validation;
                      }
                      if (value.length <= 6) {
                        return AppLocalizations.of(context)!
                            .password_format_validation;
                      }
                      return null;
                    },
                    isObscure: isObscure,
                    controller: viewModel.passwordController,
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
                        child: Icon(isObscure
                            ? Icons.visibility_off
                            : Icons.visibility)),
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
                      if (value != viewModel.passwordController.text) {
                        return AppLocalizations.of(context)!
                            .rePassword_format_validation;
                      }
                      return null;
                    },
                    isObscure: isObscure2,
                    controller: viewModel.rePasswordController,
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
                      onPressed: () {
                        viewModel.register(
                            loadingMsg: AppLocalizations.of(context)!.loading,
                            successTitleMsg:
                                AppLocalizations.of(context)!.success,
                            successMsg: AppLocalizations.of(context)!
                                .register_successfully,
                            errorTitleMsg: AppLocalizations.of(context)!.error,
                            errorMsg:
                                AppLocalizations.of(context)!.register_error);
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
      ),
    );
  }

  @override
  void hideLoading() {
    CustomDialog.hideLoading(context);
  }

  @override
  void showLoading(String message) {
    CustomDialog.showLoading(
      context: context,
      message: message,
      bgColor:
          themeProvider.isDark() ? AppColors.primaryDark : AppColors.whiteColor,
    );
  }

  @override
  void showMessage(String message, String title, [Function? posAction]) {
    CustomDialog.showAlert(
      title: title,
      posAction: posAction,
      context: context,
      posActionName: AppLocalizations.of(context)!.ok,
      message: message,
      bgColor:
          themeProvider.isDark() ? AppColors.primaryDark : AppColors.whiteColor,
    );
  }

  @override
  void gotoHome(String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }
}
