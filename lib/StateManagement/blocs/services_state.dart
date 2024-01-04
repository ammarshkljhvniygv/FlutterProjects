
import 'dart:developer';



import '../../models/provider.dart';
import '../../models/service.dart';

abstract class ServicesStates {
  const ServicesStates();
}

class ServicesStatesInit extends ServicesStates {}

class GetDataFinishSuccess extends ServicesStates {
  List<Services>? services;
  GetDataFinishSuccess({ this.services});
}

class GetDataFinishWithError extends ServicesStates {}
class GetOrdersFinishWithError extends ServicesStates {}

class GetDataStarted extends ServicesStates {}
class GetOrdersStarted extends ServicesStates {}

