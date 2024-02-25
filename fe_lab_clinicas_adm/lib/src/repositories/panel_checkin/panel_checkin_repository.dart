import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

abstract interface class PanelCheckinRepository {
  Future<Either<RepositoryException, String>> callOnPanel(
      String password, int attendantDesk);
}