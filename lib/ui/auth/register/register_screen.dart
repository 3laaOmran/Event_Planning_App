import 'package:evently_app/providers/theme_provider.dart';
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

  bool isObscure = true;
  bool isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);
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
          child: Column(
            children: [
              Image.asset(AssetsManager.eventlyLogo),
              SizedBox(height: height * 0.05),
              CustomTextFormField(
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
                    child: Icon(
                        isObscure2 ? Icons.visibility_off : Icons.visibility)),
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
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
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
    );
  }
}
