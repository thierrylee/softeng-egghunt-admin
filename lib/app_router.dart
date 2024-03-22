import 'package:flutter/material.dart';
import 'package:softeng_egghunt_admin/add_egg/add_egg_page.dart';
import 'package:softeng_egghunt_admin/egg_list/egg_list_page.dart';
import 'package:softeng_egghunt_admin/show_egg/show_egg_page.dart';

abstract class AppRouter {
  static MaterialPageRoute<dynamic> handleRoute(RouteSettings settings) {
    final screen = switch (settings.name) {
      EggListPage.routeName => const EggListPage(),
      AddEggPage.routeName => const AddEggPage(),
      String() => _buildShowEggPage(settings.name!),
      null => null,
    };

    if (screen == null) throw Exception("Invalid route: ${settings.name}");
    return MaterialPageRoute<dynamic>(
      builder: (final context) {
        return screen;
      },
      settings: settings,
    );
  }

  static ShowEggPage? _buildShowEggPage(String routeName) {
    if (routeName.startsWith(ShowEggPage.routeNamePrefix)) {
      final eggName = routeName.substring(ShowEggPage.routeNamePrefix.length);
      return ShowEggPage(eggName: eggName);
    } else {
      return null;
    }
  }
}
