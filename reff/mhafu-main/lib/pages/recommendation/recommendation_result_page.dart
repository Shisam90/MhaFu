import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhafu/api/blocs/recommended_one_cubit/recommended_one_cubit.dart';
import 'package:mhafu/api/models/recommendation_one_model.dart';

class RecommendatoionResultPage extends StatelessWidget {
  static const String routeName = '/recommendation_result_page';
  const RecommendatoionResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedOneCubit, RecommendedOneState>(
      builder: (context, state) {
        if (state.data.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text("the output value is empty"),
            ),
          );
        }
        var breakfast = state.data[0];
        var launch = state.data[1];
        var dinner = state.data[2];
        return Scaffold(
          appBar: AppBar(
            title: const Text("result page"),
          ),
          //TODO: make UI
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _RecepieDescription(mealType: "BreakFast", meal: breakfast),
                  const Divider(color: Colors.grey, thickness: 2),
                  _RecepieDescription(mealType: "Launch", meal: launch),
                  const Divider(color: Colors.grey, thickness: 2),
                  _RecepieDescription(mealType: "Dinner", meal: dinner),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RecepieDescription extends StatelessWidget {
  final String mealType;
  final RecommendedMealModel meal;

  const _RecepieDescription({
    required this.mealType,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          mealType,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Text(
          meal.name ?? "",
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        const Text(
          "Nutritational values (g):",
          style: TextStyle(fontSize: 18),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(
                borderRadius: BorderRadius.circular(10),
                width: 1,
              ),
              dividerThickness: 2,
              columns: const [
                DataColumn(
                  label: Text("Calories"),
                ),
                DataColumn(
                  label: Text("Fat"),
                ),
                DataColumn(
                  label: Text("SaturatedFat"),
                ),
                DataColumn(
                  label: Text("Cholesterol"),
                ),
                DataColumn(
                  label: Text("Sodium"),
                ),
                DataColumn(
                  label: Text("Carbohydrate"),
                ),
                DataColumn(
                  label: Text("Fiber"),
                ),
                DataColumn(
                  label: Text("Sugar"),
                ),
                DataColumn(
                  label: Text("Protein"),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                      Text("${meal.calories}"),
                    ),
                    DataCell(
                      Text("${meal.fatContent}"),
                    ),
                    DataCell(
                      Text("${meal.saturatedFatContent}"),
                    ),
                    DataCell(
                      Text("${meal.cholesterolContent}"),
                    ),
                    DataCell(
                      Text("${meal.sodiumContent}"),
                    ),
                    DataCell(
                      Text("${meal.carbohydrateContent}"),
                    ),
                    DataCell(
                      Text("${meal.fiberContent}"),
                    ),
                    DataCell(
                      Text("${meal.sugarContent}"),
                    ),
                    DataCell(
                      Text("${meal.proteinContent}"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "CookTime(s):\n ${meal.cookTime}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "PrepTime(s):\n ${meal.prepTime}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "TotalTime(s):\n ${meal.totalTime}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Text(
          "Ingredients:",
          style: TextStyle(fontSize: 18),
        ),
        Container(
          height: 150,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: meal.recipeIngredientParts!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 6,
              mainAxisSpacing: 3,
              crossAxisSpacing: 9,
            ),
            itemBuilder: (context, index) {
              return Text(
                "\u2022 ${meal.recipeIngredientParts![index]}",
                style: const TextStyle(fontSize: 17),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Instructions:",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 250,
          child: ListView.builder(
            itemCount: meal.recipeInstructions!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: Text(
                  "\u2022 ${meal.recipeInstructions![index]}",
                  style: const TextStyle(fontSize: 17),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
