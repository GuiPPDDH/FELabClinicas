import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/model/self_service_model.dart';
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
  final _step = ValueSignal(FormSteps.none);
  var _model = const SelfServiceModel();

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
    _model = _model.copyWith(documents: () => {},);
  }
}
