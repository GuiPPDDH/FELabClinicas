import 'package:fe_lab_clinicas_self_service/src/modules/self_service/documents/scan_confirm/scan_confirm_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/documents/scan_confirm/scan_confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ScanConfirmRouter extends FlutterGetItModulePageRouter {
  const ScanConfirmRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
          (i) => ScanConfirmController(),
        ),
      ];

  @override
  WidgetBuilder get view => (_) => ScanConfirmPage();
}
