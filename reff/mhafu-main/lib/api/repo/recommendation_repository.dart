import 'package:flutter/services.dart';
import 'package:mhafu/api/models/recommendation_one_model.dart';
import 'package:mhafu/api/services/recommendation_service.dart';

import '../../utils/custom_error.dart';
import '../../utils/data_excepition.dart';

import 'dart:convert';

class RecommendationRepository {
  final RecommendationService recommendationService;

  RecommendationRepository({
    required this.recommendationService,
  });

  Future<List<RecommendedMealModel>> recommendedPlan({
    required String gender,
    required String weightLossPlan,
    required int age,
    required int height,
    required int weight,
    String activity = "Maintain Weight",
  }) async {
    try {
      // final List<RecommendedMealModel> response = await recommendationService.data(
      //   gender: gender,
      //   weightLossPlan: weightLossPlan,
      //   age: age,
      //   height: height,
      //   weight: weight,
      //   activity: activity,
      // );

      //TODO: delete this after testing
      String jsonString = await rootBundle.loadString("assets/response.json");
      List<RecommendedMealModel> response = List<RecommendedMealModel>.from(
        json.decode(jsonString).map(
              (x) => RecommendedMealModel.fromJson(x),
            ),
      );

      return response;
    } on DataException catch (e) {
      print("got a error $e");
      throw CustomError(errMsg: e.message);
    } catch (e) {
      print("got a error $e");
      throw CustomError(errMsg: e.toString());
    }
  }
}
