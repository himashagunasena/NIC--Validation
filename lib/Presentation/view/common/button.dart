import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommonButton extends StatefulWidget {
  String name;
  VoidCallback onTap;
  CommonButton({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(4.w),
      color: Colors.pink,
      height: 8.h,
      width: double.infinity,
      alignment: Alignment.topRight,
      child: FlatButton(
        minWidth: double.infinity,
        height: 8.h,
        onPressed: widget.onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Text(
          widget.name,
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ),
    );
  }
}
