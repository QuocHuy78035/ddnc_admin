import 'package:ddnangcao_project/features/main/views/navbar_custom.dart';
import 'package:ddnangcao_project/utils/snack_bar.dart';
import 'package:ddnangcao_project/widgets/base_button.dart';
import 'package:ddnangcao_project/widgets/base_input.dart';
import 'package:ddnangcao_project/utils/color_lib.dart';
import 'package:ddnangcao_project/utils/size_lib.dart';
import 'package:ddnangcao_project/utils/validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../../../utils/global_variable.dart';
import '../controllers/auth_controller.dart';
import '../widgets/title_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final AuthController authController = AuthController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String message = await authController.loginUser(email, password, context);

      setState(() {
        isLoading = false;
      });
      if (message == GlobalVariable.loginSuc) {
        ShowSnackBar().showSnackBar(message, Colors.green, Colors.black, context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomerHomeScreen(),
          ),
        );
      } else {
        ShowSnackBar().showSnackBar(message, ColorLib.primaryColor, Colors.white, context);
      }
    } else {
      ShowSnackBar().showSnackBar(
          GlobalVariable.fillAllField, ColorLib.primaryColor, Colors.white, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: GetSize.symmetricPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Distance(
                    height: GetSize.distance * 6,
                  ),
                  const TitleScreen(
                    title: "Admin Login",
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  BaseInput(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return GlobalVariable.enterEmail;
                      } else if (value.isVailEmail() == false) {
                        return GlobalVariable.emailValidator;
                      }
                      return null;
                    },
                    type: "Email",
                    hintText: "Your email",
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  BaseInput(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                      return GlobalVariable.enterPass;
                      }
                      // } else if (value.length < 8) {
                      //   return GlobalVariable.passValidator;
                      // }
                      return null;
                    },
                    type: "Password",
                    hintText: "Your password",
                    isPass: true,
                  ),
                  const Distance(
                    height: GetSize.distance * 3,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: GetSize.getHeight(context) * 0.06,
                    width: GetSize.getWidth(context),
                    child: BaseButton(
                      onPressed: () async {

                        //sqlite
                        //await DatabaseHelper.saveUser('example', email, password);
                        login();
                      },
                      titleRow: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                                color: ColorLib.whiteColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  final double width;

  const Line({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: width,
      color: ColorLib.blackColor,
    );
  }
}

class Distance extends StatelessWidget {
  final double? height;
  final double? width;

  const Distance({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }
}
