import 'package:flutter_bloc/flutter_bloc.dart';
import '../recommendation/api/blocs/recommended_one_cubit/recommended_one_cubit.dart';
import '../recommendation/common/custom_error_dialogue.dart';
import '../recommendation/recommendation_result_page.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'food_journal_model.dart';
export 'food_journal_model.dart';

class FoodJournalWidget extends StatefulWidget {
  const FoodJournalWidget({Key? key}) : super(key: key);

  @override
  _FoodJournalWidgetState createState() => _FoodJournalWidgetState();
}

enum Gender { male, female }

class _FoodJournalWidgetState extends State<FoodJournalWidget> {
  late FoodJournalModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

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
    "Maintain weight",
    "Mild weight loss",
    "Weight loss",
    "Extreme weight loss",
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
      _gender = "Male";
    } else if (_selectedGender == Gender.female) {
      _gender = "Female";
    }

    context.read<RecommendedOneCubit>().getRecommendations(
          gender: _gender!,
          weightLossPlan: _weightLossPlan!,
          age: _age!,
          height: _height!,
          weight: _weight!,
          activity: _outputTexts[_currentStep],
        );
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FoodJournalModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return BlocConsumer<RecommendedOneCubit, RecommendedOneState>(
      listener: (context, state) {
        if (state.status == RecommendedOneStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
        if (state.status == RecommendedOneStatus.loaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecommendatoionResultPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondary,
              body: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 25.0, 24.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          borderWidth: 1.0,
                          buttonSize: 48.0,
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            context.pop();
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Recommended Diet',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(36.0),
                          topRight: Radius.circular(36.0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 30,
                        ),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _autovalidateMode,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Little/no exercise"),
                                          Text("very active"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Row(
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
                                  items:
                                      _weightLossPlanList.map((String value) {
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
                                    backgroundColor: Color(0xFF7165e3),
                                    minimumSize: const Size(
                                      double.infinity,
                                      50,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                  ),
                                  onPressed: _submit,
                                  child: Text(
                                    state.status == RecommendedOneStatus.loading
                                        ? "Submitting..."
                                        : "Submit",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
