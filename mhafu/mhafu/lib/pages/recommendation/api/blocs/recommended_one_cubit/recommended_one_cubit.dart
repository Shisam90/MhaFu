import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/custom_error.dart';
import '../../models/recommendation_one_model.dart';
import '../../repo/recommendation_repository.dart';


part 'recommended_one_state.dart';

class RecommendedOneCubit extends Cubit<RecommendedOneState> {
  final RecommendationRepository recommendationRepository;
  RecommendedOneCubit({
    required this.recommendationRepository,
  }) : super(RecommendedOneState.initial());

  Future<void> getRecommendations({
    required String gender,
    required String weightLossPlan,
    required int age,
    required int height,
    required int weight,
    String activity = "Maintain Weight",
  }) async {
    emit(state.copyWith(status: RecommendedOneStatus.loading));

    try {
      final List<RecommendedMealModel> response = await recommendationRepository.recommendedPlan(
        gender: gender,
        weightLossPlan: weightLossPlan,
        age: age,
        height: height,
        weight: weight,
        activity: activity,
      );

      emit(
        state.copyWith(
          status: RecommendedOneStatus.loaded,
          data: response,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: RecommendedOneStatus.error, error: e));
    }
  }
}
