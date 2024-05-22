import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPadding extends StatelessWidget {
  const MainPadding({
    this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    super.key,
  });

  final Widget? child;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left ?? 16.w,
        top ?? 20.h,
        right ?? 16.w,
        bottom ?? 20.h,
      ),
      child: child,
    );
  }
}
