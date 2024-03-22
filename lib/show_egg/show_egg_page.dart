import 'package:flutter/material.dart';
import 'package:qr_bar_code/qr/qr.dart';
import 'package:softeng_egghunt_admin/theme_factory.dart';

class ShowEggPage extends StatelessWidget {
  static const routeNamePrefix = "/showEgg/";

  static String buildRoute(String eggName) {
    return routeNamePrefix + eggName;
  }

  final String eggName;

  const ShowEggPage({super.key, required this.eggName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Code d'oeuf")),
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: QRCode(
                      data: eggName,
                      dataModuleStyle: const QRDataModuleStyle(
                        dataModuleShape: QRDataModuleShape.square,
                        color: ThemeFactory.blueMainColor,
                      ),
                      eyeStyle: const QREyeStyle(
                        eyeShape: QREyeShape.square,
                        color: ThemeFactory.blueMainColor,
                      ),
                    ),
                  ),
                ),
              ),
              Image.asset("assets/softeng_egghunt_logo.png"),
              Text(
                eggName,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ThemeFactory.blueMainColor),
              ),
              const SizedBox(height: 32),
            ],
          )),
    );
  }
}
