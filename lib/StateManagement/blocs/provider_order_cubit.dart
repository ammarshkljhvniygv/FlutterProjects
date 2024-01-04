import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/StateManagement/blocs/order_cubit.dart';
import 'package:onroad/StateManagement/blocs/provider_order_state.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/customer.dart';
import 'package:onroad/models/order.dart';
import 'package:workmanager/workmanager.dart';
import 'package:onroad/models/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'as fs;
import 'package:http/http.dart' as http;


class ProviderOrderCubit extends Cubit<ProviderOrderStates> {
  ProviderOrderCubit() : super(StateInitial());

  static ProviderOrderCubit instance(BuildContext context) =>
      BlocProvider.of(context);

  Future< /*List<Order>*/ void> getOrder(
      dynamic data, BuildContext context) async {
    // emit(StartStates());
    List<Order> orders = [];
    List<Order> orders2 = [];
    LoginCubit loginCubit = LoginCubit.instance(context);
    OrderCubit orderCubit = OrderCubit.instance(context);
    orders2.clear();
    // orders.clear();
    print('-------------------------------');

    for (int i = 0; i < data!.size; i++) {

        bool exist = false;
        Order order =
        (await orderCubit.getOrder(data!.docs[i].data()['order_id']))!;
        Customer customer =
        await loginCubit.getCustomerById2(order.customerId.toString());
        order.customer = customer;
        for (int j = 0; j < orders2.length; j++) {
          if (orders2[j].id == order.id) {
            exist = true;
            break;
          } else {
            exist = false;
          }
        }
        if (!exist) {
          if (data!.docs[i].data()['order_state']! == 'open') {
            Map<String, dynamic>? map = {
              'id': order.id.toString(),
              'type': "1"
            };
            Workmanager().registerOneOffTask(
                UniqueKey().toString(), UniqueKey().toString(), inputData: map,
                initialDelay: Duration(seconds: data!.docs[i].data()['timer']));
          }

          orders2.add(order);
        }

      orders2.sort((a, b) {
        return b.createdTime.compareTo(a.createdTime);
      });


      emit(GetOrderFinishedSuccessfully(orders: orders2));
    }
  }

  Future< /*List<Order>*/ void> getProviders(
      dynamic initialdata, int serviceType, LatLng cLocation, BuildContext context) async {
    // emit(StartStates());
    List<Provider> providers = [];
    Provider provider;
    for (int i = 0; i < initialdata!.size; i++) {
      print(initialdata!.docs[i].data()['active']);
      if (initialdata!.docs[i].data()['active'] == 'active') {
        List array = initialdata!.docs[i].data()['services'];
        if (array.contains(serviceType==1
            ? 11
            : serviceType == 22
            ? 1
            : serviceType == 21
            ? 1
            : serviceType==3
            ? 2
            : serviceType==4
            ? 4
            :  serviceType==51
            ? 3
            :  serviceType==52
            ? 3
            : 0)) {
          LoginCubit loginCubit = LoginCubit.instance(context);
          provider = await loginCubit.getProviderById2(
              initialdata!.docs[i].data()['provider_id'].toString());
          provider.providerLocation = LatLng(
              double.
              parse(initialdata!.docs[i].data()['lat'].toString()),
              double.
              parse(initialdata!.docs[i].data()['lng'].toString()));
          provider.time  = await getExpectedTime(provider.providerLocation!,cLocation);

          providers.add(provider);
          // done2 = true;
          //setState(() {});
        }
      }
    }
    emit(GetProvidersFinishedSuccessfully(providers: providers));

    // return orders2;
    //  orders.add(order);

    // setState(() {});
    //setState(() {});
  }

  Future<String> getExpectedTime(LatLng pLocation ,LatLng cLocation )async{
    final response2 = await http.get(
      Uri.parse('https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${pLocation.latitude} ${pLocation.longitude}&origins=${cLocation.latitude} ${cLocation.longitude}&units=imperial&key=AIzaSyCUIIMbkeIITf08F39BkuoqaTgq37hOgGA'),
    );
    String time ='';
    if (response2.statusCode == 200) {
      dynamic map = json.decoder.convert(response2.body);
      time = map['rows'][0]['elements'][0]['duration']['text'];

    } else {
      print(response2.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
    return time;
  }

  Future<bool> addProviderRate(
      String orderId,
      String ProviderId,
      String fast,
      String quality,
      String behavior,
      )async{
    final response2 = await http.post(
      Uri.parse(baseUrl+addProviderRate1),
      body: {
        'order_id': orderId,
        'provider_id': ProviderId,
        'fast': fast,
        'quality': quality,
        'behavior': behavior,
      }

    );
    if (response2.statusCode == 200) {

      return true ;
    } else {

      print(response2.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }
  Future<bool> addOrderRate(
      String orderId,
      String fast,
      String communication,
      String easy,
      )async{
    final response2 = await http.post(
      Uri.parse(baseUrl+addOrderRate1),
      body: {
        'order_id': orderId,
        'fast': fast,
        'communication': communication,
        'easy': easy,
      }

    );
    if (response2.statusCode == 200) {

      return true ;
    } else {

      print(response2.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

}
