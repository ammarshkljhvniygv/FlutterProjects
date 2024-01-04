import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  dynamic id;
  dynamic customerId;
  dynamic providerId;
  dynamic cost;
  dynamic serviceId;
  dynamic serviceType;
  dynamic paymentWay;
  dynamic orderState;
  LatLng providerLocation;
  LatLng customerLocation;
  Timestamp createdTime;
  Customer? customer;

  List<dynamic>? services;
  Order({
    required this.id,
    required this.customerId,
    required this.providerId,
    required this.cost,
    required this.serviceId,
    required this.paymentWay,
    required this.orderState,
    required this.providerLocation,
    required this.customerLocation,
    required this.createdTime,
    this.serviceType,
    this.customer,
  });
  static Order? fromJsonArray(dynamic data) {
    Order? order;
    // Map<String,dynamic>? maps = data;
    order = Order(
        id: data[0]["id"],
        customerId: data[0]["customer_id"],
        providerId: data[0]["provider_id"],
        cost: data[0]["cost"],
        serviceId: data[0]["service_id"],
        paymentWay: data[0]["payment_way"],
        orderState: data[0]["order_state"],
        providerLocation:
            LatLng(data[0]["provider_lat"], data[0]["provider_lng"]),
        customerLocation:
            LatLng(data[0]["customer_lat"], data[0]["customer_lng"]),
        createdTime:Timestamp.fromDate(DateTime.parse(data[0]["created_at"])) );
    return order;
  }

}
