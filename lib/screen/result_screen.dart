import 'package:flutter/material.dart';
import 'package:keyboard_dismisser_demo/model/result_model.dart';
import 'package:keyboard_dismisser_demo/util/global_function.dart';

class ResultScreen extends StatefulWidget {
  final Object? arguments;

  const ResultScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ResultClass _resultClass;

  @override
  void initState() {
    super.initState();
    if (widget.arguments != null) {
      if (widget.arguments is ResultClass) {
        _resultClass = widget.arguments as ResultClass;
      } else {}
    } else {}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar.large(
                title: const Text("Result"),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email address:",
                  ),
                  Text(
                    _resultClass.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Gender:",
                  ),
                  Text(
                    _resultClass.gender,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Age Group:",
                  ),
                  Text(ageEnumTitle(_resultClass.ageGroup)),
                  const SizedBox(height: 20),
                  const Text(
                    "Selected news categories:",
                  ),
                  Text(
                    _resultClass.selectedCategories.toString(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Have active news letter subscription:",
                  ),
                  Text(
                    _resultClass.isNewsLetterSubscribed ? "Yes" : "No",
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Frequency of daily mail:",
                  ),
                  Text(
                    _resultClass.isNewsLetterSubscribed == true
                        ? _resultClass.frequencyOfDailyMail.toInt().toString()
                        : "You don't have active news letter subscription",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
