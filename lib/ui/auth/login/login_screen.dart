import 'package:evently_app/providers/language_provider.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/ui/auth/forget_password/forget_password_screen.dart';
import 'package:evently_app/ui/auth/register/register_screen.dart';
import 'package:evently_app/ui/home/home_screen/home_screen.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/widgets/custom_text_form_field.dart';
import 'package:evently_app/utils/widgets/switch_language_button.dart';
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
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.1),
              Image.asset(AssetsManager.eventlyLogo),
              SizedBox(height: height * 0.05),
              CustomTextFormField(
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
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
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
                        Navigator.pushNamed(context, RegisterScreen.routeName);
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
            ],
          ),
        ),
      ),
    );
  }
}
