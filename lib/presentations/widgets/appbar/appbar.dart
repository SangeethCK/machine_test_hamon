import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    this.title,
    this.logo = false,
    this.centerTitle = false,
    this.actions = const [],
    this.color,
    this.iconColor,
    this.actionTitle,
    this.shadow = false,
    this.hideLeading = false,
  });

  final String? title, actionTitle;
  final bool logo, shadow, centerTitle;
  final List<Widget> actions;
  final Color? color, iconColor;
  final bool hideLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: iconColor,
        size: 20,
      ),
      backgroundColor: color,
      elevation: shadow ? null : 0,
      leadingWidth: logo ? 22.w : null,
      shape: const Border(bottom: BorderSide(color: Colors.red, width: 0.25)),
      leading: hideLeading
          ? RichText(
              text: const TextSpan(
                  text: 'Hello,',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                  TextSpan(
                      text: 'Good Moring',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black))
                ]))
          : Navigator.canPop(context)
              ? IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                )
              : null,
      titleSpacing: Navigator.canPop(context) == true ? 0 : null,
      title: title != null
          ? RichText(
              text: const TextSpan(
                  text: 'Hello,',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                  TextSpan(
                      text: 'Good Morning',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.black))
                ]))
          : null,
      centerTitle: centerTitle,
      actions: actionTitle != null
          ? [
              Center(
                child: Text(
                  actionTitle!,
                  // style: TextUtils.theme.titleMedium
                  //     ?.copyWith(fontWeight: FontWeight.w600, color: kBlack65),
                ),
              ),
              // dWidth3,
            ]
          : actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
