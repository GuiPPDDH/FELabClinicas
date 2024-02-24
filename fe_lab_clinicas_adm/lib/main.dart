import 'dart:async';
import 'dart:developer';

import 'package:fe_lab_clinicas_adm/src/bindings/lab_clinicas_application_binding.dart';
import 'package:fe_lab_clinicas_adm/src/pages/login/login_router.dart';
import 'package:fe_lab_clinicas_adm/src/pages/splash/splash_page.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    runApp(const LabClinicasAdm());
  }, (error, stack) {
    log('Erro não tratado', error: error, stackTrace: stack);
  });
}

class LabClinicasAdm extends StatelessWidget {
  const LabClinicasAdm({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: 'Lab Clinicas ADM',
      applicationBindings: LabClinicasApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(
          page: (_) => const SplashPage(),
          path: '/',
        ),
        FlutterGetItPageBuilder(
          page: (_) => const Text('To na home page'),
          path: '/home',
        ),
      ],
      pages: const [
        LoginRouter(),
      ],
    );
  }
}
