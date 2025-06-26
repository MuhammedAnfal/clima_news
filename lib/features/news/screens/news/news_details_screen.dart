import 'package:clima_news/common/widgets/custom_appbar.dart';
import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.tag,
    required this.title,
    required this.author,
    this.ontap,
    this.time,
    required this.description,
  });
  final String imageUrl, tag, title, author, description;
  final VoidCallback? ontap;
  final time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Back',
        backgroundColor: AppColors.darkBackground,
        textStyle: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: context.screenWidth * 0.05,
        ),
        leadingPadding: EdgeInsets.only(top: context.screenHeight * 0.01),
      ),
      body: SafeArea(
        child: Container(
          height: context.screenHeight,
          padding: EdgeInsets.all(context.screenWidth * 0.03),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //-- showing news image
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(imageUrl),
                  ),
                ),

                //-- news title
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteText,
                      fontSize: context.screenWidth * 0.05,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                //-- news uploaded time
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: context.screenHeight * 0.01),
                      child: Text(
                        DateFormat.yMMMd().format(time),
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteText,
                          fontSize: context.screenWidth * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),

                //-- news autor and his name
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //-- symbol of the author
                      Container(
                        margin: EdgeInsets.only(right: context.screenWidth * 0.03),
                        height: context.screenHeight * 0.03,
                        width: context.screenWidth * 0.065,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppColors.buttonColor,
                        ),
                        child: Center(
                          child: Text(
                            author[0],
                            style: GoogleFonts.poppins(color: AppColors.whiteText),
                          ),
                        ),
                      ),

                      //-- author name
                      Padding(
                        padding: EdgeInsets.only(top: context.screenHeight * 0.005),
                        child: Text(
                          author,
                          style: GoogleFonts.poppins(
                            color: AppColors.whiteText,
                            fontSize: context.screenWidth * 0.03,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.01),
                  child: Text(
                    description,
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteText,
                      fontSize: context.screenWidth * 0.04,
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
