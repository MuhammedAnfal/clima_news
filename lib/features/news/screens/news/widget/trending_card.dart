import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TrendingCard extends StatelessWidget {
  const TrendingCard({
    super.key,
    required this.imageUrl,
    required this.tag,
    required this.time,
    required this.title,
    required this.author,
    this.ontap,
  });

  final String imageUrl, tag, title, author;
  final VoidCallback? ontap;
  final time;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(
          top: context.screenHeight * 0.015,
          right: context.screenWidth * 0.055,
        ),
        width: context.screenWidth * 0.65,
        padding: EdgeInsets.all(context.screenWidth * 0.03),
        decoration: BoxDecoration(
          color: AppColors.lightBackground,
          borderRadius: BorderRadius.circular(25),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: context.screenHeight * 0.005),
                height: context.screenHeight * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child:
                      (imageUrl == '')
                          ? Image.asset(AppImages.defaultnewsImage)
                          : Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),

              //-- trending text and  date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tag,
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteText,
                      fontSize: context.screenWidth * 0.029,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(time),
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteText,
                      fontSize: context.screenWidth * 0.029,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

              //-- news des
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //-- posted user
              Padding(
                padding: EdgeInsets.only(top: context.screenWidth * 0.005),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: context.screenWidth * 0.03,
                      ),
                      height: context.screenHeight * 0.04,
                      width: context.screenWidth * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors.buttonColor,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        author,
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
