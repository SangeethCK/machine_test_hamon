import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:machine_test/domain/core/constant/colors.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();



void kSnackBar({
  required String content,
  double? height,
  Color color = Colors.white,
  IconData? icon,
  int duration = 3000,
  bool error = false,
  bool success = false,
  bool warning = false,
  bool delete = false,
  bool update = false,
  bool floating = false,
  bool infinite = false,
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentSnackBar();

  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: SizedBox(
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.red,
                size: 18.sp,
              )
            else
              error == true
                  ? Icon(
                      Icons.error_outline,
                      color: kSnackBarIconColor,
                      size: 18.sp,
                    )
                  : success == true
                      ? Icon(
                          Icons.done,
                          color: kSnackBarIconColor,
                          size: 18.sp,
                        )
                      : delete == true
                          ? Icon(
                              Icons.delete,
                              color: kSnackBarIconColor,
                              size: 18.sp,
                            )
                          : update == true
                              ? Icon(
                                  Icons.update,
                                  color: kSnackBarIconColor,
                                  size: 18.sp,
                                )
                              : const SizedBox.shrink(),
            5.horizontalSpace,
            Flexible(
              child: Text(
                content,
                softWrap: false,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                // style: FontPalette.textDarkTheme.labelLarge?.copyWith(color: kWhite),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: error
          ? kRedColor
          : success
              ? kGreenColor
              : warning
                  ? kOrangeColor
                  : delete
                      ? kYellowColor
                      : update
                          ? kBlueColor
                          : color,
      duration:
          infinite ? const Duration(days: 1) : Duration(milliseconds: duration),
      behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
      action: action,
    ),
  );
}

SnackBar kGetSnackBar({
  required BuildContext context,
  required String content,
  double? height,
  Color color = kWhite,
  IconData? icon,
  int duration = 3500,
  bool error = false,
  bool success = false,
  bool delete = false,
  bool update = false,
  bool floating = false,
  SnackBarAction? action,
}) {
  return SnackBar(
    content: SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: kSnackBarIconColor,
              size: 18.sp,
            )
          else
            error == true
                ? Icon(
                    Icons.error_outline,
                    color: kSnackBarIconColor,
                    size: 18.sp,
                  )
                : success == true
                    ? Icon(
                        Icons.done,
                        color: kSnackBarIconColor,
                        size: 18.sp,
                      )
                    : delete == true
                        ? Icon(
                            Icons.delete,
                            color: kSnackBarIconColor,
                            size: 18.sp,
                          )
                        : update == true
                            ? Icon(
                                Icons.update,
                                color: kSnackBarIconColor,
                                size: 18.sp,
                              )
                            : const SizedBox.shrink(),
          5.horizontalSpace,
          Flexible(
            child: Text(
              content,
              softWrap: false,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              // style: FontPalette.textDarkTheme.labelLarge?.copyWith(color: kWhite),
            ),
          ),
        ],
      ),
    ),
    //todo
    backgroundColor: error == true
        ? kWhite
        : success == true
            ? kWhite
            : delete == true
                ? kWhite
                : update == true
                    ? kWhite
                    : color,
    duration: Duration(milliseconds: duration),
    behavior: floating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
    action: action,
  );
}
