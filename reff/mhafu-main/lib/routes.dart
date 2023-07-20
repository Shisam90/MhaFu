import 'package:flutter/material.dart';
import 'pages/exports.dart';

Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const HomePage(),
      );

    case DietRecommendtaionFormPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const DietRecommendtaionFormPage(),
      );

    case RecommendatoionResultPage.routeName:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const RecommendatoionResultPage(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Error 404 page not found'),
          ),
        ),
      );
  }
}
