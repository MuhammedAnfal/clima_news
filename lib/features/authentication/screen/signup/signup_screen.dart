import 'package:clima_news/common/widgets/custom_button.dart';
import 'package:clima_news/features/authentication/controller/signup/signup_controller.dart';
import 'package:clima_news/features/authentication/screen/login/login_screen.dart';
import 'package:clima_news/features/authentication/screen/signup/widgets/already_have_account_button.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/string_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:clima_news/features/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  //--varailbes
  final signupController = Get.put(SignupController());

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
      CurvedAnimation(parent: _controller, curve: Interval(0.3, 1, curve: Curves.easeIn)),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.all(context.screenWidth * 0.06),
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
                              key: signupController.singUpFormkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),

                                  //-- Name Field
                                  Padding(
                                    padding: EdgeInsets.only(top: context.screenHeight * 0.03),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        controller: signupController.nameController,
                                        decoration: InputDecoration(
                                          labelText: 'Full Name',
                                          prefixIcon: Icon(Icons.person),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),

                                  //-- Email Field
                                  Padding(
                                    padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        controller: signupController.emailController,
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

                                  //-- Password Field
                                  Padding(
                                    padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        controller: signupController.passwordController,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          prefixIcon: Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              signupController.obscurePassword.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                signupController.obscurePassword.value =
                                                    !signupController.obscurePassword.value;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        obscureText: signupController.obscurePassword.value,
                                        validator:
                                            (value) => AppValidator.validatePassword(value),
                                      ),
                                    ),
                                  ),

                                  //-- Confirm Password Field
                                  Padding(
                                    padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: TextFormField(
                                        controller: signupController.confirmPasswordController,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          prefixIcon: Icon(Icons.lock_outline),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              signupController.obscureConfirmPassword.value
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                signupController.obscureConfirmPassword.value =
                                                    !signupController
                                                        .obscureConfirmPassword
                                                        .value;
                                              });
                                            },
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        obscureText:
                                            signupController.obscureConfirmPassword.value,
                                        validator:
                                            (value) => AppValidator.validateEmptyText(
                                              'confirmPassword',
                                              value,
                                            ),
                                      ),
                                    ),
                                  ),

                                  //-- Sign Up Button
                                  CustomButton(
                                    onTap: () {
                                      signupController.signUp();
                                    },
                                    margin: EdgeInsets.only(top: context.screenHeight * 0.03),
                                    text: AppStrings.signupText,
                                    loginTextStyle: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: context.screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  //--Already have account button
                                  AlreadyHaveAccountButton(
                                    onPressed: () {
                                      Get.offAll(() => LoginPage());
                                    },
                                    loginText: AppStrings.loginText,
                                    text: AppStrings.alreadyHaveAccountText,
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                    opacityAnimation: _opacityAnimation,
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
