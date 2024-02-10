import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';

abstract interface class PatientRepository {
  Future<Either<RepositoryException, PatientModel?>> findPatientByCPF(String document);
  Future<Either<RepositoryException, Unit>> update(PatientModel patientModel);
}
