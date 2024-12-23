import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/assets_manager.dart';
import 'package:evently_app/utils/text_styles.dart';
import 'package:evently_app/utils/widgets/custom_elevated_button.dart';
import 'package:evently_app/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = 'forget_password_screen';

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var forgetPasswordController = TextEditingController();

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
              Image.asset(AssetsManager.forgetPasswordImage),
              SizedBox(height: height * 0.05),
              CustomTextFormField(
                controller: forgetPasswordController,
                prefixIcon: const ImageIcon(
                  AssetImage(
                    AssetsManager.emailIcon,
                  ),
                ),
                hintText: AppLocalizations.of(context)!.email,
              ),
              SizedBox(height: height * 0.03),
              CustomElevatedButton(
                  bgColor: AppColors.primaryLight,
                  buttonText: Text(
                    AppLocalizations.of(context)!.reset_password,
                    style: TextStyles.medium20White,
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
