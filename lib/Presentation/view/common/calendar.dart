import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../util/constants.dart';


Calendar(BuildContext context) {
 return
   showDatePicker(
      context: context,
      initialDate: AppConstants.selectedDate,
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Container(
          child: Theme(
            data: ThemeData(
                colorScheme: const ColorScheme.light(
                    primary: Colors.pink,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black),
                dialogBackgroundColor: Colors.white,
                dialogTheme: DialogTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)))),
            child: child!,
          )
        );
      });
}
