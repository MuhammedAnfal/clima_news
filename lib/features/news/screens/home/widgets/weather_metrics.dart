import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherMetric extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const WeatherMetric({
    super.key,
    required this.value,
    required this.label,
    this.icon = Icons.info,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(context.screenHeight * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Icon(
                icon,
                size: context.screenHeight * 0.035,
                color: AppColors.lightBackground,
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: context.screenHeight * 0.01),
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: context.screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  top: context.screenHeight * 0.001,
                  left: context.screenWidth * 0.003,
                ),
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
