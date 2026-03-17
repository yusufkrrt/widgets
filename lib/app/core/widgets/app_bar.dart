import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    required this.context,
    this.titleWidget,
    this.leading,
    this.titleLeftPadding = 0,
    this.actions,
    super.key,
  });

  final BuildContext context;
  final Widget? titleWidget;
  final Widget? leading;
  final double titleLeftPadding;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: leading,
        title: Padding(
          padding: EdgeInsets.only(left: titleLeftPadding),
          child: titleWidget,
        ),
        actions: actions,
      );
}
