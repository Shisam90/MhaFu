part of 'recommended_one_cubit.dart';

enum RecommendedOneStatus { initial, loading, loaded, error }

class RecommendedOneState extends Equatable {
  final RecommendedOneStatus status;
  final CustomError error;
  final List<RecommendedMealModel> data;

  const RecommendedOneState({
    required this.status,
    required this.error,
    required this.data,
  });

  factory RecommendedOneState.initial() => const RecommendedOneState(
        status: RecommendedOneStatus.initial,
        error: CustomError(),
        data: [],
      );

  @override
  List<Object> get props => [status, error, data];

  @override
  bool get stringify => true;

  RecommendedOneState copyWith({
    RecommendedOneStatus? status,
    CustomError? error,
    List<RecommendedMealModel>? data,
  }) {
    return RecommendedOneState(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
