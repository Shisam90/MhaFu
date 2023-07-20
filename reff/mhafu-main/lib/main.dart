import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mhafu/api/blocs/recommended_one_cubit/recommended_one_cubit.dart';
import 'package:mhafu/api/repo/recommendation_repository.dart';
import 'package:mhafu/api/services/recommendation_service.dart';
import 'package:mhafu/constants/global_constants.dart';
import 'pages/home/home_page.dart';
import 'routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<RecommendationRepository>(
          create: (context) => RecommendationRepository(
            recommendationService: RecommendationService(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RecommendedOneCubit>(
            create: (context) => RecommendedOneCubit(
              recommendationRepository: context.read<RecommendationRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Mhafu",
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.primaryColor,
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: GlobalVariables.backgroundColor,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
          ),
          home: const HomePage(),
          onGenerateRoute: (set) => generateRoute(set),
        ),
      ),
    );
  }
}
