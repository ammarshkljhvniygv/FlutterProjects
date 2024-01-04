import 'package:onroad/models/order.dart';

abstract class ProviderHomeStates {
  const ProviderHomeStates();
}

class HomeScreenStates extends ProviderHomeStates {}

class OrderTapScreenStates extends ProviderHomeStates {
  String? orderId;
  OrderTapScreenStates({required this.orderId});
}
