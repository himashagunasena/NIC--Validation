import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../util/constants.dart';
import '../../../util/enum.dart';

class CommonRadio extends StatefulWidget {
  const CommonRadio({Key? key}) : super(key: key);

  @override
  State<CommonRadio> createState() => _CommonRadioState();
}

class _CommonRadioState extends State<CommonRadio> {
  GenderType? _genderType = AppConstants.gender;
  String gender = "default";

  @override
  Widget build(BuildContext context) {
    if (_genderType == GenderType.MALE) {
      // gender = TranslationConstants.male.t(context);
      gender = "MALE";
      print(AppConstants.gender);
    } else {
      // gender = TranslationConstants.female.t(context);
      gender = "FEMALE";
      print(AppConstants.gender);
    }
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: RadioListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              "Male",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: _genderType == GenderType.MALE
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: _genderType == GenderType.MALE
                      ? Colors.pink
                      : Colors.black),
            ),
            value: GenderType.MALE,
            groupValue: _genderType,
            onChanged: (value) {
              setState(() {
                _genderType = value as GenderType?;
                AppConstants.gender= GenderType.MALE;
              });
            },
            activeColor: Colors.pink,
          ),
        ),
        Expanded(
          flex: 1,
          child: RadioListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              "Female",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: _genderType == GenderType.FEMALE
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: _genderType == GenderType.FEMALE
                      ? Colors.pink
                      : Colors.black),
            ),
            value: GenderType.FEMALE,
            groupValue: _genderType,
            onChanged: (value) {
              setState(() {
                _genderType = value as GenderType?;
                AppConstants.gender= GenderType.FEMALE;
              });
            },
            activeColor: Colors.pink,
          ),
        ),
      ],
    );
  }

  RadioValueChanges(GenderType? value) {
    setState(() {
      _genderType = value;

      switch (_genderType) {
        case GenderType.MALE:
          break;
        case GenderType.FEMALE:
          break;
        default:
          break;
      }
    });
  }
}
