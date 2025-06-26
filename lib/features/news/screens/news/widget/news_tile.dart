import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/constants/image_constants.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.imageUrl,
    required this.author,
    required this.time,
    required this.title,
    this.ontap,
  });
  final String imageUrl, author, title;
  final DateTime time;
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: ontap,
          child: Container(
            width: context.screenWidth * 0.88,
            height: context.screenHeight * 0.18,
            margin: EdgeInsets.only(top: context.screenHeight * 0.015),
            padding: EdgeInsets.all(context.screenWidth * 0.035),
            decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //-- image container
                Container(
                  margin: EdgeInsets.only(
                    bottom: context.screenHeight * 0.005,
                    right: context.screenWidth * 0.03,
                  ),
                  height: context.screenHeight * 0.15,
                  width: context.screenWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child:
                        (imageUrl == '' || imageUrl == null)
                            ? Image.asset(AppImages.defaultnewsImage)
                            : Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),

                //-- trending text and  date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //-- posted user
                        Container(
                          margin: EdgeInsets.only(
                            right: context.screenWidth * 0.02,
                          ),
                          height: context.screenHeight * 0.027,
                          width: context.screenWidth * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.buttonColor,
                          ),
                        ),
                        SizedBox(
                          width: context.screenWidth * 0.3,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            author ?? '',
                            style: GoogleFonts.poppins(
                              color: AppColors.whiteText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //-- news des
                    SizedBox(
                      width: context.screenWidth * 0.4,
                      height: context.screenHeight * 0.07,
                      child: Text(
                        title ?? '',
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteText,
                          fontSize: context.screenWidth * 0.03,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: context.screenHeight * 0.01,
                      ),
                      child: Text(
                        DateFormat.yMMMd().format(time) ?? "",
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteText,
                          fontSize: context.screenWidth * 0.029,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    //--
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
