import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser_demo/model/chip_list_model.dart';
import 'package:keyboard_dismisser_demo/model/radio_list_model.dart';
import 'package:keyboard_dismisser_demo/model/result_model.dart';
import 'package:keyboard_dismisser_demo/route/app_route.dart';
import 'package:keyboard_dismisser_demo/util/enum.dart';
import 'package:keyboard_dismisser_demo/util/global_function.dart';
import 'package:keyboard_dismisser_demo/util/string_extension.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  String? _dropdownValue;
  final List<String> _dropdownItems = <String>[
    'Male',
    'Female',
    'Other',
    'Prefer not to say',
  ];

  AgeEnum _ageValue = AgeEnum.values[0];

  final List<ChipListClass> _chipList = [
    ChipListClass(title: 'General'),
    ChipListClass(title: 'Social'),
    ChipListClass(title: 'Auto'),
    ChipListClass(title: 'Tech'),
    ChipListClass(title: 'Legal'),
    ChipListClass(title: 'Crime'),
    ChipListClass(title: 'National'),
    ChipListClass(title: 'International'),
    ChipListClass(title: 'Lifestyle'),
    ChipListClass(title: 'Art'),
    ChipListClass(title: 'Entertainment'),
    ChipListClass(title: 'Sports'),
    ChipListClass(title: 'Legal'),
    ChipListClass(title: 'Business'),
  ];
  final List<String> _selectedCategories = [];

  bool _subscribedNewsLetter = false;
  double _dailyNewsFrequency = 1.0;

  final List<RadioListClass> _checkBoxList = [
    RadioListClass(title: 'I accept your privacy policies'),
    RadioListClass(title: 'I accept your terms & conditions'),
  ];

  final String _hintForTextField = "Enter your email address";
  final String _errorForTextField = "Please enter your valid email address";
  final String _hintForDropDown = "Choose your gender";
  final String _errorForDropDown = "Please choose your gender";
  bool _showCategoriesWarning = false;
  bool _showPPTCWarning = false;
  final String _ppTCMsg =
      "Please accept our privacy policies and terms & conditions";
  final String _selectPP = "Please accept our privacy policies";
  final String _selectTC = "Please accept our terms & conditions";

  final ShapeBorder _shapeBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  );

  @override
  void initState() {
    super.initState();
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
                title: const Text("Flutter Form Widgets"),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    emailAddressTextFormField(),
                    const SizedBox(height: 20),
                    genderSelectionDropDown(),
                    const SizedBox(height: 20),
                    ageGroupSelectionRadioListTile(),
                    const SizedBox(height: 20),
                    categorySelectionFilterChip(),
                    const SizedBox(height: 20),
                    subscriptionOptSwitchWithListTile(),
                    Visibility(
                      visible: _subscribedNewsLetter,
                      child: const SizedBox(height: 20),
                    ),
                    Visibility(
                      visible: _subscribedNewsLetter,
                      child: frequencyOfDailyMailSlider(),
                    ),
                    const SizedBox(height: 20),
                    privacyAndTermsCheckBoxListTile(),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    floatingSubmitButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailAddressTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: _hintForTextField,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            return (value ?? "").isValidEmail() ? null : _errorForTextField;
          },
        ),
      ],
    );
  }

  Widget genderSelectionDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          value: _dropdownValue,
          hint: Text(_hintForDropDown),
          onChanged: (value) {
            _dropdownValue = value ?? _dropdownValue;
            setState(() {});
          },
          validator: (value) {
            return value == null ? _errorForDropDown : null;
          },
          items: _dropdownItems.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget ageGroupSelectionRadioListTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select your age group"),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: AgeEnum.values.length,
          itemBuilder: (BuildContext context, int index) {
            AgeEnum ageEnum = AgeEnum.values[index];
            return RadioListTile<AgeEnum>(
              shape: _shapeBorder,
              activeColor: Colors.blue,
              contentPadding: EdgeInsets.zero,
              title: Text(ageEnumTitle(ageEnum)),
              value: ageEnum,
              groupValue: _ageValue,
              onChanged: (value) {
                _ageValue = value ?? _ageValue;
                setState(() {});
              },
            );
          },
        ),
      ],
    );
  }

  Widget categorySelectionFilterChip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("News categories preference"),
        Row(
          children: [
            Expanded(
              child: Wrap(
                spacing: 10,
                children: List.generate(
                  growable: true,
                  _chipList.length,
                  (index) {
                    ChipListClass chip = _chipList[index];
                    return FilterChip(
                      checkmarkColor: Colors.white,
                      selectedColor: Colors.blue,
                      padding: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      label: Text(
                        chip.title,
                        style: TextStyle(
                          color: chip.value
                              ? Colors.white
                              : Theme.of(context).textTheme.titleSmall?.color,
                        ),
                      ),
                      selected: chip.value,
                      onSelected: (bool value) {
                        chip.value = value;
                        if (value) {
                          _selectedCategories.add(chip.title);
                        } else {
                          _selectedCategories.remove(chip.title);
                        }
                        validateFilterChip();
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: _showCategoriesWarning,
          child: Text(
            categoryCountString(),
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget subscriptionOptSwitchWithListTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const SizedBox(),
          minVerticalPadding: 0,
          minLeadingWidth: 0,
          shape: _shapeBorder,
          contentPadding: EdgeInsets.zero,
          onTap: () {
            _subscribedNewsLetter = !_subscribedNewsLetter;
            setState(() {});
          },
          title: const Text("Subscribe to our newsletter?"),
          trailing: Switch.adaptive(
            activeColor: Colors.blue,
            value: _subscribedNewsLetter,
            onChanged: (value) {
              _subscribedNewsLetter = !_subscribedNewsLetter;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget privacyAndTermsCheckBoxListTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "By clicking these boxes I agree that I have read the privacy policies as well as terms & conditions.",
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: _checkBoxList.length,
          itemBuilder: (BuildContext context, int index) {
            RadioListClass news = _checkBoxList[index];
            return CheckboxListTile(
              shape: _shapeBorder,
              activeColor: Colors.blue,
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              title: Text(news.title),
              value: news.value,
              onChanged: (value) {
                news.value = value ?? news.value;
                validatePPTC();
                setState(() {});
              },
            );
          },
        ),
        Visibility(
          visible: _showPPTCWarning && errorMessageForPPTC() != "",
          child: Text(
            errorMessageForPPTC(),
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
        )
      ],
    );
  }

  Widget frequencyOfDailyMailSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Frequency of daily mail"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("1"),
            const SizedBox(width: 10),
            Expanded(
              child: Slider.adaptive(
                activeColor: Colors.blue,
                label: _dailyNewsFrequency.toInt().toString(),
                min: 1,
                max: 5,
                divisions: 4,
                value: _dailyNewsFrequency,
                onChanged: (value) {
                  _dailyNewsFrequency = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(width: 10),
            const Text("5"),
          ],
        ),
      ],
    );
  }

  Widget floatingSubmitButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.clear_all),
              onPressed: resetValuesToTheirDefault,
              label: const Text('Clear & reset form'),
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if ((_formKey.currentState?.validate() ?? false) ||
                    (validateFilterChip() == false) ||
                    (validatePPTC() == false)) {
                  ResultClass result = ResultClass(
                    emailAddress: _controller.value.text.trim(),
                    gender: _dropdownValue ?? "",
                    ageGroup: _ageValue,
                    selectedCategories: _selectedCategories,
                    isNewsLetterSubscribed: _subscribedNewsLetter,
                    frequencyOfDailyMail: _dailyNewsFrequency,
                  );
                  GoRouter.of(context).push(
                    AppRoute().resultScreen,
                    extra: result,
                  );
                } else {}
                setState(() {});
              },
              child: const Icon(
                Icons.navigate_next,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool validateFilterChip() {
    return _showCategoriesWarning =
        _chipList.where((element) => element.value == true).length < 3
            ? true
            : false;
  }

  String categoryCountString() {
    int index = _chipList.where((element) => element.value == true).length;
    return "Please select at least ${3 - index} items from above";
  }

  bool validatePPTC() {
    final temp = _checkBoxList.where((element) => element.value == false);
    final index = _checkBoxList.indexWhere((element) => element.value == false);
    if (temp.length == 2) {
      _showPPTCWarning = true;
    } else if (index == 0) {
      _showPPTCWarning = true;
    } else if (index == 1) {
      _showPPTCWarning = true;
    } else {
      _showPPTCWarning = false;
    }
    return _showPPTCWarning;
  }

  String errorMessageForPPTC() {
    final temp = _checkBoxList.where((element) => element.value == false);
    final index = _checkBoxList.indexWhere((element) => element.value == false);
    String returnValue = "";
    if (temp.length == 2) {
      returnValue = _ppTCMsg;
    } else if (index == 0) {
      returnValue = _selectPP;
    } else if (index == 1) {
      returnValue = _selectTC;
    } else {
      returnValue = "";
    }
    return returnValue;
  }

  void resetValuesToTheirDefault() {
    _controller.clear();
    _dropdownValue = null;
    _ageValue = AgeEnum.values[0];
    _selectedCategories.clear();
    _showCategoriesWarning = false;
    _subscribedNewsLetter = false;
    _dailyNewsFrequency = 1.0;
    final uncheckPPTC = _checkBoxList.where((element) => element.value == true);
    for (var element in uncheckPPTC) {
      element.value = false;
    }
    _showPPTCWarning = false;
    _formKey.currentState?.reset();
    setState(() {});
    return;
  }
}
