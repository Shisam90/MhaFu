import 'package:flutter/services.dart';

import '../../utils/custom_error.dart';
import '../../utils/data_excepition.dart';

import 'dart:convert';

import '../models/recommendation_one_model.dart';
import '../services/recommendation_service.dart';

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
      final List<RecommendedMealModel> response =
          await recommendationService.data(
        gender: gender,
        weightLossPlan: weightLossPlan,
        age: age,
        height: height,
        weight: weight,
        activity: activity,
      );

      // String jsonString = await rootBundle.loadString("assets/response.json");
      // List<RecommendedMealModel> response = List<RecommendedMealModel>.from(
      //   json.decode(jsonString).map(
      //         (x) => RecommendedMealModel.fromJson(x),
      //       ),
      // );

      return response;
    } on DataException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
