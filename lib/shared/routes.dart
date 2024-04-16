import 'package:flutter/material.dart';
import 'package:playfair/view/main/home.dart';
import 'package:playfair/view/team/team.dart';

class AppRoutes {
  const AppRoutes();

  static int selectedRoute = 0;

  static ValueNotifier<int> selectedRouteNotifier = ValueNotifier<int>(0);

  static const List<Widget> _homeRoutes = [Body(), TeamInfo()];

  static void _updateSelectedRoute({required int index}) {
    selectedRoute = index;
    selectedRouteNotifier.value = selectedRoute;
  }

  static void go({required Locations location}) {
    switch (location) {
      case Locations.home:
        {
          _updateSelectedRoute(index: 0);
          return;
        }
      case Locations.teamInfo:
        {
          _updateSelectedRoute(index: 1);
          return;
        }
      default:
        {
          _updateSelectedRoute(index: 0);
          return;
        }
    }
  }

  static Widget current() => _homeRoutes[selectedRoute];
}

enum Locations { home, teamInfo }
