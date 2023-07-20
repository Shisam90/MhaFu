import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhafu/api/blocs/recommended_one_cubit/recommended_one_cubit.dart';
import 'package:mhafu/pages/common/custom_error_dialogue.dart';
import 'package:mhafu/pages/recommendation/recommendation_result_page.dart';

class DietRecommendtaionFormPage extends StatefulWidget {
  static const String routeName = '/diet-recommendation-form-page';
  const DietRecommendtaionFormPage({super.key});

  @override
  State<DietRecommendtaionFormPage> createState() => _DietRecommendtaionFormPageState();
}

enum Gender { male, female }

class _DietRecommendtaionFormPageState extends State<DietRecommendtaionFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  double _sliderValue = 0.0;
  int _currentStep = 0;

  final List<String> _outputTexts = [
    'Little/no exercise',
    'Light exercise',
    'Moderate exercise (3-5 days/wk)',
    'Very active (6-7 days/wk)',
    'Extra active (very active & physical job)',
  ];

  Gender? _selectedGender;

  final List<String> _weightLossPlanList = [
    "Maintain Weight",
    "Mild Weight Loss",
    "Weight Loss",
    "Extreme Weight Loss",
  ];

  String? _gender;
  String? _weightLossPlan;
  int? _age;
  int? _height;
  int? _weight;

  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();

    if (_selectedGender == Gender.male) {
      _gender = "male";
    } else if (_selectedGender == Gender.female) {
      _gender = "female";
    }

    print("Weight Loss Plan: $_weightLossPlan \n");
    print("Age: $_age \n");
    print("Gender: $_gender \n");
    print("Height: $_height \n");
    print("Weight: $_weight \n");
    print("Activity: ${_outputTexts[_currentStep]} \n");

    // context.read<RecommendedOneCubit>().getRecommendations(
    //       gender: _gender!,
    //       weightLossPlan: _weightLossPlan!,
    //       age: _age!,
    //       height: _height!,
    //       weight: _weight!,
    //       activity: _outputTexts[_currentStep],
    //     );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecommendedOneCubit, RecommendedOneState>(
      listener: (context, state) {
        if (state.status == RecommendedOneStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
        if (state.status == RecommendedOneStatus.loaded) {
          Navigator.pushNamed(context, RecommendatoionResultPage.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Form Page"),
          ),
          body: GestureDetector(
            onTapDown: (_) => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Age',
                          prefixIcon: Icon(Icons.person_add_alt),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter age';
                          }
                          if (int.parse(value) < 16) {
                            return 'Age must me more than 16';
                          }
                          if (int.parse(value) > 100) {
                            return 'Age must me less than 100';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _age = int.parse(value!.trim());
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Height(cm)',
                          hintText: "in cm",
                          prefixIcon: Icon(Icons.height),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your height';
                          }
                          if (int.parse(value) < 0) {
                            return 'Please enter a valid height';
                          }
                          if (int.parse(value) > 250) {
                            return 'Please enter a valid height';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _height = int.parse(value!.trim());
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          labelText: 'Weight(kg)',
                          prefixIcon: Icon(Icons.line_weight),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your weight';
                          }
                          if (int.parse(value) < 16) {
                            return 'Age must me more than 16';
                          }
                          if (int.parse(value) > 100) {
                            return 'Age must me less than 100';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _weight = int.parse(value!.trim());
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<Gender>(
                              contentPadding: const EdgeInsets.all(0),
                              value: Gender.male,
                              groupValue: _selectedGender,
                              title: const Text("male"),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Gender>(
                              contentPadding: const EdgeInsets.all(0),
                              value: Gender.female,
                              groupValue: _selectedGender,
                              title: const Text("female"),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [Text("Activity")],
                            ),
                            Text(
                              _outputTexts[_currentStep],
                              style: const TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.center,
                            ),
                            Slider(
                                value: _sliderValue,
                                min: 0.0,
                                max: 4.0,
                                divisions: 4,
                                onChanged: (value) {
                                  setState(() {
                                    _sliderValue = value;
                                    _currentStep = value.round();
                                  });
                                }),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Little/no exercise"),
                                Text("very active"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Choose Your Weight Loss Plan"),
                        ],
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Maintain Weight',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                        items: _weightLossPlanList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          _weightLossPlan = value!;
                        },
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                        ),
                        onPressed: _submit,
                        child: Text(
                          state.status == RecommendedOneStatus.loading ? "Submitting..." : "Submit",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
