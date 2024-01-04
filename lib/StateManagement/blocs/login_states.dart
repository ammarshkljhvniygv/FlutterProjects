import 'package:onroad/models/customer.dart';
import 'package:onroad/models/provider.dart';

abstract class LoginStates {
  const LoginStates();
}

class LoginStateInitial extends LoginStates {}

class LoginStarted extends LoginStates {}

class LoginProviderStarted extends LoginStates {}

class LoginFinishedSuccessfully extends LoginStates {
  Customer? customer;
  Provider? provider;

  LoginFinishedSuccessfully({required this.customer, required this.provider});
}

class LoginProviderFinishedSuccessfully extends LoginStates {
  Customer? customer;
  Provider? provider;

  LoginProviderFinishedSuccessfully(
      {required this.customer, required this.provider});
}

class LoginFinishedWithError extends LoginStates {}

class LogoutState extends LoginStates {}

class LogoutProviderState extends LoginStates {}
