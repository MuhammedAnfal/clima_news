import 'package:flutter/material.dart';

class AlreadyHaveAccountButton extends StatelessWidget {
  const AlreadyHaveAccountButton({
    super.key,
    required Animation<double> opacityAnimation,
    required this.text,
    required this.textStyle,
    required this.loginText,
    this.onPressed,
  }) : _opacityAnimation = opacityAnimation;

  final Animation<double> _opacityAnimation;
  final String text, loginText;
  final TextStyle textStyle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          TextButton(
            onPressed: onPressed,
            child: Text(loginText, style: textStyle),
          ),
        ],
      ),
    );
  }
}
