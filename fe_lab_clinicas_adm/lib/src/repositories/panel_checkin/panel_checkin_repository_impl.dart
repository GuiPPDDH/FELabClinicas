import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/panel_checkin/panel_checkin_repository.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

class PanelCheckinRepositoryImpl implements PanelCheckinRepository {
  final RestClient restClient;

  PanelCheckinRepositoryImpl({required this.restClient});

  @override
  Future<Either<RepositoryException, String>> callOnPanel(
      String password, int attendantDesk) async {
    try {
      final Response(data: {'id': id}) = await restClient.auth.post(
        '/painelCheckin',
        data: {
          'password': password,
          'date_time': DateTime.now().toIso8601String(),
          'attendant_desk': attendantDesk,
        },
      );

      return Right(id);
    } on Exception catch (e, s) {
      log('Erro ao chamar o paciente no painel', error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
