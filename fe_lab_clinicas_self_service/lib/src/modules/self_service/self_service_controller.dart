import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/information_form/information_form_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum FormSteps {
  none,
  whoIAm,
  findPatient,
  patient,
  documents,
  done,
  restart,
}

class SelfServiceController with MessageStateMixin {
  final InformationFormRepository informationFormRepository;

  SelfServiceController({
    required this.informationFormRepository,
  });

  final _step = ValueSignal(FormSteps.none);
  var _model = const SelfServiceModel();
  var password = '';

  FormSteps get step => _step();
  SelfServiceModel get model => _model;

  void startProcess() {
    _step.forceUpdate(FormSteps.whoIAm);
  }

  void setWhoIAmDataStepAndNext(String name, String lastName) {
    _model = _model.copyWith(
      name: () => name,
      lastName: () => lastName,
    );

    _step.forceUpdate(FormSteps.findPatient);
  }

  void goToFormPatient(PatientModel? patient) {
    _model = _model.copyWith(
      patient: () => patient,
    );
    _step.forceUpdate(FormSteps.patient);
  }

  void clearForm() {
    _model = _model.clear();
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);
    clearForm();
  }

  void updatePatientAndGoDocument(PatientModel? patient) {
    _model = _model.copyWith(
      patient: () => patient,
    );
    _step.forceUpdate(FormSteps.documents);
  }

  void registerDocument(DocumentType documentType, String filePath) {
    final documents = _model.documents ?? {};

    if (documentType == DocumentType.healthInsuranceCard) {
      documents[documentType]?.clear();
    }

    final values = documents[documentType] ?? [];
    values.add(filePath);
    documents[documentType] = values;
    _model = _model.copyWith(
      documents: () => documents,
    );
  }

  void clearDocuments() {
    _model = _model.copyWith(
      documents: () => {},
    );
  }

  Future<void> finalize() async {
    final result = await informationFormRepository.register(model).asyncLoader();

    switch (result) {
      case Left():
        showError('Erro ao registrar atendimento');
      case Right():
        password = '${_model.name} ${_model.lastName}';
        _step.forceUpdate(FormSteps.done);
    }
  }
}
