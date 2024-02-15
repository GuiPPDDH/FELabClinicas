import 'package:fe_lab_clinicas_self_service/src/modules/self_service/documents/documents_page.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/documents/scan/scan_page.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/documents/scan_confirm/scan_confirm_router.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/done/done_page.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/find_patient/find_patient_router.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/patient/patient_router.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_page.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/who_i_am/who_i_am_page.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/information_form/information_form_repository.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/information_form/information_form_repository_impl.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/patient/patient_repository.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/patient/patient_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class SelfServiceModule extends FlutterGetItModule {
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton(
          (i) => SelfServiceController(informationFormRepository: i()),
        ),
        Bind.lazySingleton<PatientRepository>(
          (i) => PatientRepositoryImpl(restClient: i()),
        ),
        Bind.lazySingleton<InformationFormRepository>(
          (i) => InformationFormRepositoryImpl(restClient: i()),
        ),
      ];

  @override
  String get moduleRouteName => '/self-service';

  @override
  Map<String, WidgetBuilder> get pages => {
        '/': (context) => const SelfServicePage(),
        '/who-i-am': (context) => const WhoIAmPage(),
        '/find-patient': (context) => const FindPatientRouter(),
        '/patient': (context) => const PatientRouter(),
        '/documents': (context) => const DocumentsPage(),
        '/documents/scan': (context) => const ScanPage(),
        '/documents/scan/confirm': (context) => const ScanConfirmRouter(),
        '/done': (context) => DonePage(),
      };
}
