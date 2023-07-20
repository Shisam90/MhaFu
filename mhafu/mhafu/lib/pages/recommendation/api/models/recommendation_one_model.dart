// To parse this JSON data, do
//
//     final recommendedMealModel = recommendedMealModelFromJson(jsonString);

import 'dart:convert';

List<RecommendedMealModel> recommendedMealModelFromJson(String str) =>
    List<RecommendedMealModel>.from(
      json.decode(str).map(
            (x) => RecommendedMealModel.fromJson(x),
          ),
    );

String recommendedMealModelToJson(List<RecommendedMealModel> data) =>
    json.encode(List<dynamic>.from(
      data.map((x) => x.toJson()),
    ));

class RecommendedMealModel {
  int? recipeId;
  String? name;
  int? cookTime;
  int? prepTime;
  int? totalTime;
  List<String>? recipeIngredientParts;
  double? calories;
  double? fatContent;
  double? saturatedFatContent;
  double? cholesterolContent;
  double? sodiumContent;
  double? carbohydrateContent;
  double? fiberContent;
  double? sugarContent;
  double? proteinContent;
  List<String>? recipeInstructions;

  RecommendedMealModel({
    this.recipeId,
    this.name,
    this.cookTime,
    this.prepTime,
    this.totalTime,
    this.recipeIngredientParts,
    this.calories,
    this.fatContent,
    this.saturatedFatContent,
    this.cholesterolContent,
    this.sodiumContent,
    this.carbohydrateContent,
    this.fiberContent,
    this.sugarContent,
    this.proteinContent,
    this.recipeInstructions,
  });

  factory RecommendedMealModel.initial() => RecommendedMealModel(
        recipeId: 0,
        name: '',
        cookTime: 0,
        prepTime: 0,
        totalTime: 0,
        recipeIngredientParts: [],
        calories: 0,
        fatContent: 0,
        saturatedFatContent: 0,
        cholesterolContent: 0,
        sodiumContent: 0,
        carbohydrateContent: 0,
        fiberContent: 0,
        sugarContent: 0,
        proteinContent: 0,
        recipeInstructions: [],
      );

  factory RecommendedMealModel.fromJson(Map<String, dynamic> json) => RecommendedMealModel(
        recipeId: json["RecipeId"],
        name: json["Name"],
        cookTime: json["CookTime"],
        prepTime: json["PrepTime"],
        totalTime: json["TotalTime"],
        recipeIngredientParts: json["RecipeIngredientParts"] == null
            ? []
            : List<String>.from(json["RecipeIngredientParts"]!.map((x) => x)),
        calories: json["Calories"]?.toDouble(),
        fatContent: json["FatContent"]?.toDouble(),
        saturatedFatContent: json["SaturatedFatContent"]?.toDouble(),
        cholesterolContent: json["CholesterolContent"]?.toDouble(),
        sodiumContent: json["SodiumContent"]?.toDouble(),
        carbohydrateContent: json["CarbohydrateContent"]?.toDouble(),
        fiberContent: json["FiberContent"]?.toDouble(),
        sugarContent: json["SugarContent"]?.toDouble(),
        proteinContent: json["ProteinContent"]?.toDouble(),
        recipeInstructions: json["RecipeInstructions"] == null
            ? []
            : List<String>.from(json["RecipeInstructions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "RecipeId": recipeId,
        "Name": name,
        "CookTime": cookTime,
        "PrepTime": prepTime,
        "TotalTime": totalTime,
        "RecipeIngredientParts": recipeIngredientParts == null
            ? []
            : List<dynamic>.from(recipeIngredientParts!.map((x) => x)),
        "Calories": calories,
        "FatContent": fatContent,
        "SaturatedFatContent": saturatedFatContent,
        "CholesterolContent": cholesterolContent,
        "SodiumContent": sodiumContent,
        "CarbohydrateContent": carbohydrateContent,
        "FiberContent": fiberContent,
        "SugarContent": sugarContent,
        "ProteinContent": proteinContent,
        "RecipeInstructions":
            recipeInstructions == null ? [] : List<dynamic>.from(recipeInstructions!.map((x) => x)),
      };
}
