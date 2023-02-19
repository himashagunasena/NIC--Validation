import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nic_validation/Presentation/view/common/button.dart';
import 'package:nic_validation/Presentation/view/common/error_msg.dart';
import 'package:nic_validation/Presentation/view/common/radio_button.dart';
import 'package:nic_validation/Presentation/view/common/textbox.dart';
import 'package:nic_validation/Presentation/view/nic_check_ml.dart';
import 'package:sizer/sizer.dart';

import '../../util/constants.dart';
import '../../util/validation.dart';
import 'common/calendar.dart';

class NicValidation extends StatefulWidget {
  const NicValidation({Key? key}) : super(key: key);

  @override
  State<NicValidation> createState() => _NicValidationState();
}

class _NicValidationState extends State<NicValidation> {
  TextEditingController birthdayController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  bool validator = false;

  bool Validate() {
    bool validator = false;
    if (DateFormat('yyyy-MM-dd').format(AppConstants.selectedDate) == date) {
      showAlert(context, "Select your Birthday");
      validator = true;
    } else if (nicController.text == "") {
      showAlert(context, "Please enter your NIC number");
      print("invalid");
      print(AppConstants.selectedDate);
      validator = true;
    } else if (Validation.NicValidation(nicController.text) == false) {
      print(AppConstants.selectedDate);
      showAlert(context,
          "Invalid NIC. Not match with the birthday or gender. Please check again");
      print("invalid");
      validator = true;
    } else {
      validator = false;
    }
    return validator;
  }

  //late DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    if (birthdayController.text.isNotEmpty) {
      print(AppConstants.selectedDate);
    }
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("NIC Checker"),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Expanded(
            child: SingleChildScrollView(
              child:Container(
            //alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
            ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 1.5.h),
                    CommonTextbox(
                      title: "Date of Birth",
                      hint: date,
                      onTap: () {
                        _selectedDate(context);
                      },
                      controller: birthdayController,
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.pink,
                      ),
                      function: AlwaysDisableFocusNode(),
                    ),
                    SizedBox(height: 5.h),
                    const CommonRadio(),
                    SizedBox(height: 5.h),
                    CommonTextbox(
                        title: "NIC number",
                        hint: "",
                        onTap: () {},
                        controller: nicController),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          CommonButton(
              name: "Next",
              onTap: () {
                if (Validate()) {
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NicMlValidation()));
                }
              })
        ],
      ),
    );
  }

  _selectedDate(BuildContext context) async {
    DateTime? newDate = await Calendar(context);

    if (newDate != null) {
      setState(() {
        AppConstants.selectedDate = newDate;
        birthdayController.text =
            DateFormat("yyyy-MM-dd").format(AppConstants.selectedDate);
        // ..selection = TextSelection.fromPosition(TextPosition(
        //     offset: _textEditingController.text.length,
        //     affinity: TextAffinity.upstream))
      });
    }
  }
}

class AlwaysDisableFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
