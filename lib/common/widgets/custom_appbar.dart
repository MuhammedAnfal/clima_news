import 'package:clima_news/features/utils/constants/app_colors.dart';
import 'package:clima_news/features/utils/extension/size_extension.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.isCenterTitle = false,
    this.leading,
    this.leadingPadding,
    this.actions,
    this.textStyle,
    this.backgroundColor,
  });
  final String title;
  final bool isCenterTitle;
  final Widget? leading;
  final EdgeInsetsGeometry? leadingPadding;
  final List<Widget>? actions;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    return AppBar(
      surfaceTintColor: Colors.transparent,
      centerTitle: isCenterTitle,
      backgroundColor: backgroundColor,
      leading: Padding(
        padding: leadingPadding ?? EdgeInsets.zero,
        child: leading ?? leadingIcon(context, canPop: canPop),
      ),
      actions: actions,

      title: Padding(
        padding: EdgeInsets.only(top: context.screenWidth * 0.03),
        child: Text(title, style: textStyle),
      ),
    );
  }

  Widget? leadingIcon(BuildContext context, {required bool canPop}) {
    if (canPop) {
      return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
      );
    }
    return null;
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
