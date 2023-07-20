import "dart:convert";

import "package:http/http.dart" as http;
import "package:mhafu/api/models/recommendation_one_model.dart";

import "../../utils/http_error_handler.dart";

class RecommendationService {
  Future<List<RecommendedMealModel>> data({
    required String gender,
    required String weightLossPlan,
    required int age,
    required int height,
    required int weight,
    String activity = "Maintain Weight",
  }) async {
    http.Client client = http.Client();

    final Uri url = Uri.parse("http://10.0.2.2:8000/predict");

    try {
      final http.Response response = await client.post(
        url,
        body: jsonEncode({
          "gender": gender,
          "age": age,
          "height": height,
          "weight": weight,
          "activity": activity,
          "mealsPerDay": 3,
          "weightLossPlan": weightLossPlan,
        }),
        headers: {
          "content-type": "application/json",
        },
      );

      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      return recommendedMealModelFromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
