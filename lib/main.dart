import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:softeng_egghunt_admin/app_router.dart';
import 'package:softeng_egghunt_admin/egg_list/egg_list_page.dart';
import 'package:softeng_egghunt_admin/firebase_options.dart';
import 'package:softeng_egghunt_admin/theme_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebase();
  runApp(const SoftEngEggHuntAdminApp());
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
}

class SoftEngEggHuntAdminApp extends StatelessWidget {
  const SoftEngEggHuntAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.handleRoute,
      darkTheme: ThemeFactory.buildDarkTheme(),
      theme: ThemeFactory.buildLightTheme(),
      themeMode: ThemeMode.system,
      title: "SoftEng EggHunt - Admin",
      home: const EggListPage(),
    );
  }
}
