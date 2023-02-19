import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class CommonTextbox extends StatefulWidget {
  String title;
  String hint;
  Icon? icon;
  FocusNode? function;
  VoidCallback onTap;
  TextEditingController controller;
  CommonTextbox({
    Key? key,
    required this.title,
    required this.hint,
    this.icon,
    this.function,
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  State<CommonTextbox> createState() => _CommonTextboxState();
}

class _CommonTextboxState extends State<CommonTextbox> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 2.h),
      Text(
        widget.title,
        style: TextStyle(
          fontSize: 12.sp,
        ),
        textAlign: TextAlign.left,
      ),
      SizedBox(height: 1.h),
      TextField(
        textInputAction: TextInputAction.done,
        keyboardAppearance: Brightness.light,
        style: TextStyle(fontSize: 14.sp),
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hint,
          suffixIcon: widget.icon,
         focusedBorder: const UnderlineInputBorder(borderSide:BorderSide(color:Colors.pink,))
        ),
        focusNode: widget.function,
        onTap: widget.onTap,
      ),
    ]);
  }
}
