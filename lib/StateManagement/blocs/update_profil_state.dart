import 'package:onroad/models/customer.dart';
import 'package:onroad/models/provider.dart';

abstract class UpdateProfileState {
  const UpdateProfileState();
}

class UpdateProfileStateInitial extends UpdateProfileState {}

class UpdateProfileStarted extends UpdateProfileState {}

class UpdateProfileSuccessfully extends UpdateProfileState {
  Customer? customer;
  Provider? provider;
  String? result;
  UpdateProfileSuccessfully(
      {required this.customer, required this.provider, this.result});
}

class UpdateProfileFinishedWithError extends UpdateProfileState {}
