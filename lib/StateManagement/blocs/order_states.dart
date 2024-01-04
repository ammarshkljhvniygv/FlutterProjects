import 'package:onroad/models/order.dart';

abstract class OrderStates {
  const OrderStates();
}

class OrderStateInitial extends OrderStates {}

class OrderState extends OrderStates {
  Order? order;
  OrderState({required this.order});
}

class OrderStarted extends OrderStates {}

class OrderTimeOut extends OrderStates {}

class OrderAcceptAble extends OrderStates {
  String? orderId;
  OrderAcceptAble({required this.orderId});
}

class OrderAccepted extends OrderStates {}

class OrderRejected extends OrderStates {}

class OrderCanceled extends OrderStates {}

class OrderPayCheck extends OrderStates {}

class OrderPayChecked extends OrderStates {}

class OrderPayDoesNotCheck extends OrderStates {}

class OrderFinishedSuccessfully extends OrderStates {
  // Order? order;
  OrderFinishedSuccessfully(/*{required this.order}*/);
}

class OrderFinishedWithError extends OrderStates {}

//provider
class OrderProviderAcceptAble extends OrderStates {
  Order order;
  OrderProviderAcceptAble({required this.order});
}

class OrderProviderAccepted extends OrderStates {
  Order order;
  OrderProviderAccepted({required this.order});
}
