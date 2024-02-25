import 'dart:developer';

import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/panel_checkin/panel_checkin_repository.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/patient_information_form/patient_information_form_repository.dart';

class CallNextPatientService {
  final PatientInformationFormRepository patientInformationFormRepository;
  final AttendantDeskAssignmentRepository attendantDeskAssignmentRepository;
  final PanelCheckinRepository panelCheckinRepository;

  CallNextPatientService({
    required this.patientInformationFormRepository,
    required this.attendantDeskAssignmentRepository,
    required this.panelCheckinRepository,
  });

  Future<Either<RepositoryException, PatientInformationFormModel?>>
      execute() async {
    final result = await patientInformationFormRepository.callNextToCheckIn();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final form?):
        return updatePanel(form);
      case Right():
        return Right(null);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
      PatientInformationFormModel form) async {
    final resultDesk =
        await attendantDeskAssignmentRepository.getDeskAssignment();
    switch (resultDesk) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final deskNumber):
        final panelResult =
            await panelCheckinRepository.callOnPanel(form.password, deskNumber);
        switch (panelResult) {
          case Left(value: final exception):
            log(
              'Atenção! Não foi possível chamar o paciente',
              error: exception,
              stackTrace: StackTrace.fromString(
                  'Atenção! Não foi possível chamar o paciente'),
            );
            return Right(form);
          case Right():
            return Right(form);
        }
    }
  }
}
