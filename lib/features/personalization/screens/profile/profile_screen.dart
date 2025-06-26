import 'package:clima_news/features/authentication/controller/signup/signup_controller.dart';
import 'package:clima_news/features/personalization/controllers/user_controller.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light gray background
      body: Center(
        child: Container(
          width:
              //-- Max width 400px or screen width
              context.screenWidth > 400 ? 400 : context.screenWidth,
          margin: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.lightBackground,
            //-- Large rounded corners
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 15,
                //-- changes position of shadow
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: SingleChildScrollView(
            // Allows scrolling if content overflows
            child: Column(
              children: [
                // Header Background Section
                Container(
                  height: context.screenHeight * 0.3,
                  width: context.screenWidth,
                  decoration: const BoxDecoration(
                    color: AppColors.buttonColor, // Orange background
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      // Illustration Image (positioned bottom right)
                      Center(
                        child: Lottie.asset(
                          // Replace with your actual illustration image URL or asset path
                          AppImages.onBoardingimage3,
                          width: context.screenWidth * 0.6, // Responsive width
                        ),
                      ),
                    ],
                  ),
                ),

                // Profile Card Section (overlapping the header)
                Transform.translate(
                  offset: const Offset(0.0, -60.0), // Move up to overlap
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipPath(
                      clipper:
                          ProfileCardClipper(), // Custom clipper for the top shape
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            24.0,
                          ), // Apply border radius to container
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(
                                0,
                                -5,
                              ), // Shadow for the card
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            // Profile Picture
                            Padding(
                              padding: const EdgeInsets.only(top: 60),
                              child: Image.asset(
                                AppImages.avatarIcon,
                                fit: BoxFit.cover,
                                height: context.screenHeight * 0.08,
                              ),
                            ),
                            Text(
                              userController.user.value.fullName,
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: context.screenHeight * 0.01,
                              ),
                              child: Text(
                                userController.user.value.email,
                                style: GoogleFonts.poppins(
                                  fontSize: context.screenWidth * 0.03,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24.0),

                            // Profile Stats
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CustomClipper for the profile card to create the rounded top corners
class ProfileCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    const radius = 24.0; // Corresponds to the border-radius applied

    path.moveTo(0, radius); // Start from top-left, after the curve
    path.arcToPoint(
      Offset(radius, 0),
      radius: const Radius.circular(radius),
      clockwise: false,
    ); // Top-left curve
    path.lineTo(size.width - radius, 0); // Line to top-right, before the curve
    path.arcToPoint(
      Offset(size.width, radius),
      radius: const Radius.circular(radius),
      clockwise: false,
    ); // Top-right curve
    path.lineTo(size.width, size.height); // Line to bottom-right
    path.lineTo(0, size.height); // Line to bottom-left
    path.close(); // Close the path

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
