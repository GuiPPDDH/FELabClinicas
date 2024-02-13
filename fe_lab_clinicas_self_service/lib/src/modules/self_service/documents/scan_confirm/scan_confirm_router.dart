import 'package:fe_lab_clinicas_self_service/src/modules/self_service/documents/scan_confirm/scan_confirm_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/documents/scan_confirm/scan_confirm_page.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/documents/documents_repository.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/documents/documents_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class ScanConfirmRouter extends FlutterGetItModulePageRouter {
  const ScanConfirmRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<DocumentsRepository>(
          (i) => DocumentsRepositoryImpl(restClient: i()),
        ),
        Bind.lazySingleton(
          (i) => ScanConfirmController(documentsRepository: i()),
        ),
      ];

  @override
  WidgetBuilder get view => (_) => ScanConfirmPage();
}
