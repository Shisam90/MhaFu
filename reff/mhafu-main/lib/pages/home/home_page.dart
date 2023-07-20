import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhafu/api/blocs/recommended_one_cubit/recommended_one_cubit.dart';
import 'package:mhafu/pages/recommendation/diet_recommendation_form_page.dart';
import 'package:mhafu/pages/recommendation/recommendation_result_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home-page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                DietRecommendtaionFormPage.routeName,
              ),
              child: const Text("go to form"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<RecommendedOneCubit>().getRecommendations(
                      gender: "",
                      weightLossPlan: "",
                      age: 0,
                      height: 1,
                      weight: 32,
                    );
                Navigator.pushNamed(
                  context,
                  RecommendatoionResultPage.routeName,
                );
              },
              child: const Text("go to form result"),
            ),
          ],
        ),
      ),
    );
  }
}
