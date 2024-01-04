import 'package:onroad/models/order.dart';
import 'package:onroad/models/provider.dart';

abstract class ProviderOrderStates {
  const ProviderOrderStates();
}

class StateInitial extends ProviderOrderStates {}

class StartStates extends ProviderOrderStates {}

class GetOrderFinishedSuccessfully extends ProviderOrderStates {
  List<Order> orders;

  GetOrderFinishedSuccessfully({required this.orders});
}

class GetProvidersFinishedSuccessfully extends ProviderOrderStates {
  List<Provider> providers;

  GetProvidersFinishedSuccessfully({required this.providers});
}
