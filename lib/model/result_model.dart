import 'package:keyboard_dismisser_demo/util/enum.dart';

class ResultClass {
  String emailAddress;
  String gender;
  AgeEnum ageGroup;
  List<String> selectedCategories;
  bool isNewsLetterSubscribed;
  double frequencyOfDailyMail;

  ResultClass({
    required this.emailAddress,
    required this.gender,
    required this.ageGroup,
    required this.selectedCategories,
    required this.isNewsLetterSubscribed,
    required this.frequencyOfDailyMail,
  });
}
