import 'package:flutter/material.dart';
import 'package:machine_test/domain/core/constant/string_constant.dart';
import 'package:machine_test/domain/utilities/font/font_palette.dart';

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
    this.hideLeading = false,
  });

  final String? title, actionTitle;
  final bool logo, centerTitle;
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
      backgroundColor: Colors.white,
      elevation: 0,
      leading: hideLeading
          ? const SizedBox()
          : Navigator.canPop(context)
              ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 22,
                    ),
                  ),
                )
              : null,
      titleSpacing:
          Navigator.canPop(context) ? 0 : NavigationToolbar.kMiddleSpacing,
      title: title == null
          ? null
          : RichText(
              text: TextSpan(
                  text: StringConstant.hello,
                  style: FontPalette.head1,
                  children: [
                  TextSpan(
                      text: StringConstant.goodMorining,
                      style: FontPalette.headSub2)
                ])),
      centerTitle: centerTitle,
      actions: actionTitle != null
          ? [
              Center(
                child: Text(
                  actionTitle!,
                ),
              ),
            ]
          : actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
