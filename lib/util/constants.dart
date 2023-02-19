import 'package:permission_handler/permission_handler.dart';

import 'enum.dart';


class AppConstants {
  static DateTime selectedDate = DateTime.now();
  static GenderType? gender = GenderType.MALE;
  static String noImage = "assets/images/no_image.png";

}
recognitionResult(recognition) {
  double confidence = (recognition['confidence'] * 100);
  var index = recognition['index'];
  var label = recognition['label'].split("_").join(" ");
  //return "$label (${confidence.roundToDouble()}%), $index";
  return "$index";
}

checkPermissions(context) async {
  var cameraStatus = await Permission.camera.status;
  if (cameraStatus.isDenied) {
    await Permission.camera.request();
  }
}