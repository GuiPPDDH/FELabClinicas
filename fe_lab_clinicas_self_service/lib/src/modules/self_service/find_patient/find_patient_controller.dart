import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/patient/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FindPatientController with MessageStateMixin {
  final PatientRepository _patientRepository;

  FindPatientController({
    required PatientRepository patientRepository,
  }) : _patientRepository = patientRepository;

  final _patient = ValueSignal<PatientModel?>(null);
  final _patientNotFound = ValueSignal<bool?>(null);

  PatientModel? get patient => _patient();
  bool? get patientNotFound => _patientNotFound();

  Future<void> findPatientByDocument(String document) async {
    final patientResult = await _patientRepository.findPatientByCPF(document);
    PatientModel? patient;
    bool patientNotFound;

    switch (patientResult) {
      case Right(value: PatientModel patientModel?):
        patientNotFound = false;
        patient = patientModel;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
      case Left():
        showError('Erro ao buscar paciente');
        return;
    }

    batch(() {
      _patient.forceUpdate(patient);
      _patientNotFound.forceUpdate(patientNotFound);
    });
  }
}
