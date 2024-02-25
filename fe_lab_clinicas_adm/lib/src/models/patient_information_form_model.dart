// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:fe_lab_clinicas_adm/src/models/patient_model.dart';

part 'patient_information_form_model.g.dart';

@JsonEnum(valueField: 'id')
enum PatientInformationFormStatus {
  waiting('Waiting'),
  checkIn('CheckIn'),
  beingAttended('Being Attended');

  final String id;
  const PatientInformationFormStatus(this.id);
}

@JsonSerializable()
class PatientInformationFormModel {
  final String id;
  final PatientModel patient;
  @JsonKey(name: 'health_insurance_card')
  final String healthInsuranceCard;
  @JsonKey(name: 'medical_order')
  final List<String> medicalOrder;
  final String password;
  @JsonKey(name: 'date_created')
  final DateTime dateCreated;
  final PatientInformationFormStatus status;

  PatientInformationFormModel({
    required this.id,
    required this.patient,
    required this.healthInsuranceCard,
    required this.medicalOrder,
    required this.password,
    required this.dateCreated,
    required this.status,
  });

  factory PatientInformationFormModel.fromJson(Map<String, dynamic> json) =>
      _$PatientInformationFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientInformationFormModelToJson(this);
}
