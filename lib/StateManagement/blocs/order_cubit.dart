import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:onroad/constant.dart';
import 'package:onroad/models/order.dart';

import 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderStateInitial());

  static OrderCubit instance(BuildContext context) => BlocProvider.of(context);
  Order? order;

  Future<Order?> createOrder(
    dynamic customerId,
    dynamic providerId,
    dynamic cost,
    dynamic serviceId,
    LatLng providerLocation,
    LatLng customerLocation,
  ) async {
    final response2 = await http.post(
        Uri.parse(
          '$baseUrl${createOrder1}',
        ),
        headers: {"Content-Type": "application/json"},
        body: utf8.encode(json.encode({
          'customer_id': customerId.toString(),
          'provider_id': providerId.toString(),
          'provider_lat': providerLocation.latitude,
          'provider_lng': providerLocation.longitude,
          'customer_lat': customerLocation.latitude,
          'customer_lng': customerLocation.longitude,
          'cost': cost.toString(),
          'service_id': serviceId.toString(),
          'order_state': 'open'
        })));
    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      Order? order = Order.fromJsonArray(map['order_data']);
      emit(OrderAcceptAble(orderId: order!.id.toString()));
      return order;
    } else {
      print(response2.body);
      emit(OrderFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<Order?> getOrder(
    dynamic orderId,
  ) async {
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl${getOrderDetails1}id=$orderId',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      Order? order = Order.fromJsonArray(map['order_data']);
      return order;
    } else {
      print(response2.body);
      emit(OrderFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<bool> updateOrderState(String state,String id)async{

    final response2 = await http.post(
        Uri.parse(
          '$baseUrl${updateOrderState1}',
        ),
        body: {
          'id':id,
          'order_state':state
        }

    );

    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      if (map['result'] == 'successe') {
        return true;
      } else {
        //     emit(GetDataFinishWithErrorP());
        return false;
      }
    }else{
      print(response2.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }
  Future<bool> updateOrderCost(String id,String cost)async{

    final response2 = await http.get(
        Uri.parse(
          '$baseUrl${updateOrderCost1} id=$id&cost=$cost',
        ),


    );

    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      if (map['result'] == 'successe') {
        return true;
      } else {
        //     emit(GetDataFinishWithErrorP());
        return false;
      }
    }else{
      print(response2.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }


  Future<void> addCanceledOrderReason(
    dynamic orderId,
    dynamic cancelReason,
  ) async {
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl${addCanceledOrderReason1} order_id=$orderId&cancel_reason=$cancelReason',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);
/*      dynamic map = json.decoder.convert(response2.body);
      Order? order = Order.fromJsonArray(map['data']);
      emit(OrderAcceptAble(order: order));*/
      // return order;
    } else {
      print(response2.body);
      emit(OrderFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  void makeOrderAcceptAble(String? orderId) {
    emit(OrderAcceptAble(orderId: orderId));
  }

  void makeOrderCanceled() {
    emit(OrderCanceled());
  }

  void makeOrderAccepted() {
    emit(OrderAccepted());
  }

  void makeOrderProviderAccepted(Order order) {
    emit(OrderProviderAccepted(order: order));
  }

  void makeOrderOrderFinishedSuccessfully() {
    emit(OrderFinishedSuccessfully());
  }
  void makeOrderPayCheck() {
    emit(OrderPayCheck());
  }
  void makeOrderPayDoesNotCheck() {
    emit(OrderPayDoesNotCheck());
  }
  void makeOrderFinishedSuccessfully() {
    emit(OrderFinishedSuccessfully());
  }
  void makeOrderPayChecked() {
    emit(OrderPayChecked());
  }


  void makeOrderTimeOut() {
    emit(OrderTimeOut());
  }

  void makeOrderProviderAcceptAble(Order order) {
    emit(OrderProviderAcceptAble(order: order));
  }

  void makeOrderRejected() {
    emit(OrderRejected());
  }
}
