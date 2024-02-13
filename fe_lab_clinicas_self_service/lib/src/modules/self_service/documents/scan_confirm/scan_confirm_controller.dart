import 'dart:typed_data';
import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/documents/documents_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ScanConfirmController with MessageStateMixin {
  final DocumentsRepository documentsRepository;
  final pathRemoteStorage = signal<String?>(null);

  ScanConfirmController({
    required this.documentsRepository,
  });

  Future<void> uploadImage(Uint8List imageBytes, String fileName) async {
    final result = await documentsRepository.uploadImage(imageBytes, fileName).asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao fazer o upload da imagem');
      case Right(value: final pathFile):
        pathRemoteStorage.value = pathFile;
    }
  }
}
