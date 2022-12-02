import 'package:keyboard_dismisser_demo/util/enum.dart';

String ageEnumTitle(AgeEnum ageEnum) {
  String returnValue = "";
  switch (ageEnum) {
    case AgeEnum.under18:
      returnValue = "Under 18";
      break;
    case AgeEnum.above18:
      returnValue = "Above 18";
      break;
  }
  return returnValue;
}
