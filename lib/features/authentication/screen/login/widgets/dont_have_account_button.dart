import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DontHaveAccountButton extends StatelessWidget {
  const DontHaveAccountButton({
    super.key,
    required Animation<double> opacityAnimation,
    required this.dontHaveText,
    required this.signUpText,
    this.onPressed,
  }) : _opacityAnimation = opacityAnimation;

  final Animation<double> _opacityAnimation;
  final String dontHaveText, signUpText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: context.screenHeight * 0.015),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dontHaveText,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                signUpText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
