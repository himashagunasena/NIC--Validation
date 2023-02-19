import 'package:intl/intl.dart';
import 'constants.dart';
import 'enum.dart';

class Validation {
  static bool NicValidation(String nic) {
    //common variables
    var year = DateTime.utc(AppConstants.selectedDate.year);
    String yearstring = DateFormat('yyyy').format(year);
    final may = DateTime.utc(AppConstants.selectedDate.year, 5, 25);
    final januaryinthis = DateTime(AppConstants.selectedDate.year - 1, 12, 31);
    final feb = DateTime(AppConstants.selectedDate.year, 2);
    final febinthis = DateTime(AppConstants.selectedDate.year, 3, 1)
        .difference(DateTime(AppConstants.selectedDate.year, 2, 1))
        .inDays;
    var bday = AppConstants.selectedDate.difference(januaryinthis).inDays + 1;
    var lastyear = DateTime.utc(1999);
    var newyear = lastyear.year - year.year;
    bool validate = false;
    String newbday = "";

    //leap year validation
    if (AppConstants.selectedDate.month <= feb.month) {
      print(febinthis);
      bday = bday - 1;
    } else if (febinthis == 29 &&
        AppConstants.selectedDate.month > feb.month &&
        (AppConstants.selectedDate.compareTo(may) <= -1)) {
      bday = bday - 1;
    } else {
      bday = bday;
    }

// check female or not
    if (AppConstants.gender == GenderType.FEMALE) {
      newbday = (bday + 500).toString();
      print(bday);
    } else {
      if (bday.toString().length < 2) {
        newbday = "00" + bday.toString();
      } else if (bday.toString().length < 3) {
        newbday = "0" + bday.toString();
      } else {
        newbday = bday.toString();
      }
    }
//
    // old nic with 10 numbers (before 2000)
    if (nic.length == 10 && newyear >= 0) {
      var nicpart1 = nic.substring(0, 2);
      var nicpart2 = nic.substring(2, 5);
      var nicpart4 = nic.substring(5, 9);
      var nicpart3 = nic.substring(nic.length - 1, nic.length);
      var yeardigit = yearstring.toString().substring(2);

      if (nicpart1 == yeardigit) {
        print(AppConstants.gender);
        print(newbday);
        print(bday);
        print(AppConstants.selectedDate);
        //print(may);
        if (nicpart2 == newbday) {
          print("valid");
          if (double.tryParse(nicpart4) != null) {
            validate = true;
            if (nicpart3 == "v" ||
                nicpart3 == "V" ||
                nicpart3 == "x" ||
                nicpart3 == "X") {
              print("VALID NIC");
              validate = true;
              return validate;
            } else {
              print("INVALID  NIC");
              validate = false;
              return validate;
            }
          } else {
            print("invalid");
            validate = false;
            return validate;
          }
        }
      } else {
        print(AppConstants.selectedDate);
        print(nicpart1);
        validate = false;
        return validate;
      }
    }

    // old nic with 12 numbers (before 2000)
    if (nic.length == 12 && newyear >= 0) {
      var nicpart1 = nic.substring(0, 4);
      var nicpart2 = nic.substring(4, 7);
      var nicpart4 = nic.substring(nic.length - 4, nic.length);
      var nicpart3 = nic.substring(7, 8).toString();
      var yeardigit = yearstring.toString();

      if (nicpart1 == yeardigit) {
        //print(kConstantOldNIC);
        print(nicpart1);
        print(nicpart2);
        print(nicpart4);
        if (nicpart2 == newbday) {
          print("valid");
          if (double.tryParse(nicpart4) != null &&
              double.tryParse(nicpart3) == 0) {
            print("valid");
            validate = true;
            return validate;
          } else {
            print("invalid");
            validate = false;
            return validate;
          }
        }
      } else {
        print(nicpart1);
        validate = false;
        return validate;
      }
    }
    return validate;
  }
}
