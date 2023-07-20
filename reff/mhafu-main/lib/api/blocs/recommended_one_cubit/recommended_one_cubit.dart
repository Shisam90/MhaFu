import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mhafu/api/models/recommendation_one_model.dart';
import 'package:mhafu/api/repo/recommendation_repository.dart';
import 'package:mhafu/utils/custom_error.dart';

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
