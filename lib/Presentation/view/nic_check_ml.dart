import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:nic_validation/Presentation/view/common/button.dart';
import 'package:nic_validation/Presentation/view/common/error_msg.dart';
import 'package:nic_validation/Presentation/view/common/textbox.dart';
import 'package:nic_validation/Presentation/view/success.dart';
import 'package:sizer/sizer.dart';
import '../../util/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite/tflite.dart';
import 'package:tflite/tflite.dart';
import 'package:nic_validation/Presentation/view/common/error_msg.dart';

class NicMlValidation extends StatefulWidget {
  NicMlValidation({
    Key? key,
  }) : super(key: key);

  @override
  State<NicMlValidation> createState() => _NicMlValidationState();
}

class _NicMlValidationState extends State<NicMlValidation> {
  bool _loading = true;
  File? _image;

  List _recognitions = [];

  String scannedText = "";
  List scanList = [];
  List nicList = [];
  bool textScanning = false;

  final ImagePicker _picker = ImagePicker();

  _loadImage({required bool isCamera}) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
      getRecognisedText(image!);
      if (image == null) {
        return null;
      }
      _image = File(image.path);
      _detectImage(_image!);
    } catch (e) {
      checkPermissions(context);
    }
  }

  // bool validate = false;
  //late String msg;
  // bool Validator() {
  //   if (_recognitions[0]==true && _recognitions[1]==false && _recognitions[2]==false) {
  //     return validate = false;
  //   }
  //   else{
  //     // else{
  //     return validate=true;}
  //   return validate;
  // }

  _detectImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _recognitions = recognitions!;
      //print(_recognitions[0]);
    });
  }

  _reset() {

    setState(() {
      _loading = true;
      _image = null;
     nicController.text="";
     scannedText="";
    });
  }

  loadModel() async {
    Tflite.close();
    await Tflite.loadModel(
      model: "assets/model/model.tflite",
      labels: "assets/model/labels.txt",
    );
  }

  final nicController = TextEditingController();
  var screenName1;

  @override
  void initState() {
    loadModel();
    nicController.text = scannedText;
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f5f6),
      appBar: AppBar(
        title: const Text("NIC Detector"),
        actions: [
          if (!_loading)
            IconButton(
              onPressed: () => _reset(),
              icon: const FaIcon(FontAwesomeIcons.trashAlt, size: 20),
            )
        ],
      ),
      body:

      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonButton(
                onTap: () {
                  _loadImage(isCamera: true);
                },
                name: 'Open Camera',
              ),
              CommonButton(
                onTap: () {
                  _loadImage(isCamera: false);
                },
                name: 'Open Gallery',
              ),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  // height: 35.h,
                  width: 100.w,
                  //padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child: DottedBorder(
                    color: Colors.pink,
                    strokeWidth: 2,
                    dashPattern: [8, 4],
                    child: Center(
                      child: Column(children: [
                        _loading && _image == null
                            ? Column(
                                children: [
                                  Container(
                                      height: 25.h,
                                      width: 50.w,
                                      child: Image.asset(AppConstants.noImage)),
                                  //SizedBox(height: 5.h,),
                                  Text(
                                    "Upload image here",
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  )
                                ],
                              )
                            : Container(
                                padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                                width: 50.w,
                                child: Image.file(_image!)),


                      ]),
                    ),

                    //const Spacer(),
                    //  !_loading
                    //      ? Spacer(
                    //  )
                    //      :
                    // Container(padding:EdgeInsets.only(bottom: 40.h),
                    // child: Text(
                    //    "Upload image here",
                    //    style: TextStyle(
                    //      color: Colors.pink,
                    //      fontSize: 12.sp,
                    //    ),
                    //  )),
                  )),
              SizedBox(height: 0.h),
              CommonTextbox(
                title:"NIC Value",
                // isInfoIconVisible: false,
                // formatter: "",
                //autofill: scannedText,
                controller: nicController, onTap: () {  }, hint: '',),

              const SizedBox(height: 10),
              CommonButton(
                  name: "Next",
                  onTap: () {
                   if (recognitionResult(_recognitions[0]) == "0") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SuccessView()));
                      print(recognitionResult(_recognitions[0]));
                    } else if (recognitionResult(_recognitions[0]) == "2")  {
                      showAlert(context, "invalid selfie: wear masks");

                    }
                    else{
                      showAlert(context, "invalid selfie");
                      print(recognitionResult(_recognitions[0]));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    scanList = [];
    String x = "";
    String y = "";
    nicList = [];
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = line.text;
        scanList.add(scannedText);
        // scannedText=scanList[4];

      }
    }
    print(scanList);
    RegExp _numeric = RegExp(r'^-?[0-9]+$');
    bool isNumeric(String str) {
      return _numeric.hasMatch(str);
    }

    for (int i = 0; i < scanList.length; i++) {
      scanList[i] = scanList[i].replaceAll(RegExp(r"\s+"), "");
      if (scanList[i].length == 10 &&
          isNumeric(scanList[i].substring(0, 9)) == true &&
          (scanList[i].substring(9, scanList[i].length) == "v" ||
              scanList[i].substring(9, scanList[i].length) == "V")) {
        x = scanList[i].substring(0, 9);
        //y = scanList[i].substring(9,scanList[i].length);
        scannedText = scanList[i];
        print(x);
        break;
      }
      if (scanList[i].length == 9 &&
          isNumeric(scanList[i].substring(0, 9)) == true) {
        x = scanList[i].substring(0, 9);

        if (scanList[i + 1] == "v" || scanList[i + 1] == "V") {
          scannedText = scanList[i] + "V";
        } else {
          scannedText = scanList[i] + "V/X";
        }
        print(x);
        break;
      } else {
        nicList.add(scanList[i]);
        if (nicList.length == scanList.length) {
          scannedText = "NIC image is not clear and Try Again x2";
          print(nicList.length);
        } else {}
      }
      if ((scanList[i].length > 12 || scanList[i].length == 12) &&
          isNumeric(scanList[i]
              .substring(scanList[i].length - 12, scanList[i].length)) ==
              true) {
        y = scanList[i].substring(scanList[i].length - 12, scanList[i].length);
        scannedText = y;
        print(y);
        break;
      } else {
        nicList.add(scanList[i]);
        if (nicList.length == scanList.length) {
          scannedText = "NIC image is not clear and Try Again x1";
          print(nicList.length);
        } else {}
      }
    }
    textScanning = false;
    setState(() {
      nicController.text=scannedText;
    });
  }
}
