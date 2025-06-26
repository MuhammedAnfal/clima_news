import 'package:clima_news/features/authentication/controller/login/login_controller.dart';
import 'package:clima_news/features/authentication/screen/login/widgets/dont_have_account_button.dart';
import 'package:clima_news/common/widgets/custom_button.dart';
import 'package:clima_news/features/authentication/screen/signup/signup_screen.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:clima_news/features/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  //-- variables

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.3, 1, curve: Curves.easeInCirc)),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.backGroundGradient,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(context.screenWidth * 0.05),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Card(
                          surfaceTintColor: Color(0xff334552),
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(context.screenWidth * 0.05),
                            child: Form(
                              key: loginController.loginFormKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  //-- Email Field
                                  Padding(
                                    padding: EdgeInsets.only(top: context.screenHeight * 0.03),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        controller: loginController.emailController,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          prefixIcon: Icon(Icons.email),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator:
                                            (value) => AppValidator.validateEmail(value),
                                      ),
                                    ),
                                  ),

                                  //--Password Field with
                                  Padding(
                                    padding: EdgeInsets.only(top: context.screenHeight * 0.03),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        controller: loginController.passwordController,
                                        decoration: InputDecoration(
                                          labelText: AppStrings.passwordText,
                                          prefixIcon: Icon(Icons.lock),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        obscureText: true,
                                        validator:
                                            (value) => AppValidator.validatePassword(value),
                                      ),
                                    ),
                                  ),

                                  //-- Login Button with ripple animation
                                  CustomButton(
                                    onTap: () {
                                      loginController.isLoading.value
                                          ? null
                                          : loginController.emailAndPasswordSignIn();
                                    },
                                    margin: EdgeInsets.only(top: context.screenHeight * 0.03),
                                    text: AppStrings.loginText,
                                    loginTextStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: context.screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //-- Sign up text with animation
                                  DontHaveAccountButton(
                                    onPressed: () {
                                      Get.to(() => SignupPage());
                                      //--clearing the controller when navigation works
                                      loginController.emailController.clear();
                                      loginController.passwordController.clear();
                                    },
                                    opacityAnimation: _opacityAnimation,
                                    dontHaveText: AppStrings.dontHaveAccountText,
                                    signUpText: AppStrings.signupText,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
