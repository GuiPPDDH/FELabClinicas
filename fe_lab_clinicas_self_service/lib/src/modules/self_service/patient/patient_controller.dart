import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/patient/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessageStateMixin {
  final PatientRepository _patientRepository;
  PatientModel? patient;
  final _nextStep = signal<bool>(false);

  PatientController({
    required PatientRepository patientRepository,
  }) : _patientRepository = patientRepository;

  bool get nextStep => _nextStep();

  void goNextStep() {
    _nextStep.value = true;
  }

  Future<void> saveAndNext(RegisterPatientModel patient) async {
    final result = await _patientRepository.register(patient);

    switch (result) {
      case Left():
        showError('Erro ao atualizar dados do paciente, chame o atendente');
      case Right(value: final patient):
        showInfo('Paciente cadastrado com sucesso');
        this.patient = patient;
        goNextStep();
    }
  }

  Future<void> updateAndNext(PatientModel patientModel) async {
    final updateResult = await _patientRepository.update(patientModel);

    switch (updateResult) {
      case Left():
        showError('Erro ao atualizar dados do paciente, chame o atendente');
      case Right():
        showInfo('Paciente atualizado com sucesso');
        patient = patientModel;
        goNextStep();
    }
  }
}
