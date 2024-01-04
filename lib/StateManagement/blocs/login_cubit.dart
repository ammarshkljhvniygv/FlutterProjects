import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:onroad/StateManagement/blocs/login_states.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/manager/cash_manager.dart';
import 'package:onroad/models/car.dart';
import 'package:onroad/models/customer.dart';
import 'package:onroad/models/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onroad/models/user_data.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStateInitial());

  static LoginCubit instance(BuildContext context) => BlocProvider.of(context);

  Customer? customer;
  Provider? provider;

  void login() {
    emit(LoginFinishedSuccessfully(customer: customer, provider: provider));
  }

  void loginDone(
    Customer? customer,
    Provider? provider,
  ) {
    emit(LoginFinishedSuccessfully(customer: customer, provider: provider));
  }

  void logout() {
    emit(LogoutState());
  }

  void logoutProvider() {
    emit(LogoutProviderState());
  }

  Future<bool> addJoiningRequest({required String providerId}) async {
    // emit(LoginStarted());
    final response2 = await http.get(Uri.parse('$baseUrl$addJoiningRequest1 provider_id=$providerId'),
       );
    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      return map['result'] == 'seccesse'?true:false;
    } else {

      print(response2.body);
      emit(LoginFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<Provider> registrationProvider(
      String userName,
      String phoneNumber,
      String email,
      String password,
      bool license,
      bool repairShop,
      String address,
      String carNumber,
      String workType,
      List<dynamic> services) async {
    // emit(LoginStarted());
    final response2 = await http.post(Uri.parse('$baseUrl$providerRegister'),
        headers: {"Content-Type": "application/json"},
        body: utf8.encode(json.encode({
          'user_name': userName,
          'phone_number': phoneNumber,
          'password': password,
          'repair_shop': repairShop,
          'address': address,
          'license': license,
          'work_type': workType,
          'email': email,
          'car_number': carNumber,
          'servises': services,
        })));
    if (response2.statusCode == 200) {
      dynamic map = json.decoder.convert(response2.body);
      print(map['provider_data']);
      print(map['Services_ids']);
      Provider? provider = Provider.fromJsonArray(map['provider_data']);
      List<dynamic> services = map['Services_ids'];
      /*List<dynamic> servicesIds = [];
      for (int i = 0; i < services.length; i++) {
        servicesIds.add(services[i]['service_id']);
      }*/
      provider!.services = services;
      this.provider = provider;
      /*  emit(LoginFinishedSuccessfully(
          customer: customer, provider: this.provider));*/
      return provider;
    } else {
      print(response2.body);
      emit(LoginFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<String?> loginProvider(
    String userName,
    String password,
  ) async {
    emit(LoginProviderStarted());
    final response2 = await http.get(
      Uri.parse(
          '$baseUrl$providerLogin1 user_name=$userName&password=$password'),
    );
    if (response2.statusCode == 200) {
      dynamic map = json.decoder.convert(response2.body);
      if (map['code'] == '400') {
        print(map);
        return map['result'];
      }
      print(map);
      Provider? provider = Provider.fromJsonArray(map['provider_data']);
      List<dynamic> services = map['provider_services'];
      List<dynamic> servicesIds = [];
      for (int i = 0; i < services.length; i++) {
        servicesIds.add(services[i]['service_id']);
      }
      provider!.services = servicesIds;
      this.provider = provider;
      await FirebaseMessaging.instance.subscribeToTopic("p"+provider.id.toString());
      await FirebaseMessaging.instance.subscribeToTopic('providers');
      UserData userData = UserData(userId: provider.id.toString(), userType: 'provider', sound: true);
      await CacheManager.getInstance()!.storeUserData(userData);
      emit(LoginProviderFinishedSuccessfully(
          customer: customer, provider: this.provider));
      return null;
    } else {
      print(response2.body);
      emit(LoginFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<String> checkProviderUserName(String userName) async {
    final response2 = await http.get(
      Uri.parse('$baseUrl${checkUserName}user_name=$userName'),
    );
    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      return map['result'];
    } else {
      print(response2.body);
      emit(LoginFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<Provider> getProviderById(String id) async {
    final response3 =
        await http.get(Uri.parse('$baseUrl$getProviderById1 id=$id'));
    if (response3.statusCode == 200) {
      print(response3.body);
      dynamic map = json.decoder.convert(response3.body);

      print(map);
      Provider? provider = Provider.fromJsonArray(map['provider_data']);
      List<dynamic> services = map['Services_ids'];
      List<dynamic> servicesIds = [];
      for (int i = 0; i < services.length; i++) {
        servicesIds.add(services[i]['service_id']);
      }
      provider!.services = servicesIds;
      this.provider = provider;

      emit(LoginProviderFinishedSuccessfully(
          customer: customer, provider: provider));
      return provider;
    } else {
      print(response3.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<Provider> getProviderById2(String id) async {
    final response3 =
        await http.get(Uri.parse('$baseUrl$getProviderById1 id=$id'));
    if (response3.statusCode == 200) {
      print(response3.body);
      dynamic map = json.decoder.convert(response3.body);

      print(map);
      Provider? provider = Provider.fromJsonArray(map['provider_data']);
      List<dynamic> services = map['Services_ids'];
      List<dynamic> servicesIds = [];
      for (int i = 0; i < services.length; i++) {
        servicesIds.add(services[i]['service_id']);
      }
      provider!.services = servicesIds;
      this.provider = provider;
      return provider;
    } else {
      print(response3.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }
  Future<bool> getProviderState(String id) async {
    final response3 =
    await http.get(Uri.parse('$baseUrl$getProviderState1 id=$id'));
    if (response3.statusCode == 200) {
      print(response3.body);
      dynamic map = json.decoder.convert(response3.body);

      return map['provider_state'].toString()=='1'?true:false;
    } else {
      print(response3.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }
  Future<dynamic> getProviderLocation(String id) async {
    print(id);

    final response3 =
    await http.get(Uri.parse('$baseUrl$getProviderLocation1 id=$id'));
    if (response3.statusCode == 200) {
      print(response3.body);
      dynamic map = json.decoder.convert(response3.body);
      return map;
    } else {
      print(response3.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }
  Future<void> setProviderLocation(String id,String lat , String lng) async {
    final response3 =
    await http.get(Uri.parse('$baseUrl$setProviderLocation1 id=$id & lat=$lat & lng=$lng '));
    if (response3.statusCode == 200) {
      print(response3.body);
      dynamic map = json.decoder.convert(response3.body);
      print(map);
     // return map['provider_state']==1?true:false;
    } else {
      print(response3.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }
  Future<double> getProviderRate(String id) async {
    final response3 =
    await http.post(Uri.parse('$baseUrl$getProviderRate1 '),body: {'id':id});
    if (response3.statusCode == 200) {
      print(response3.body);
      dynamic map = json.decoder.convert(response3.body);
      List<dynamic> rates = map['rate'] ;
      double totalRate = 0;
      for(int i = 0 ; i < rates.length ; i++){
        double avrageRate =  (double.parse(rates[i]['fast']) + double.parse(rates[i]['quality']) + double.parse(rates[i]['behavior']))/3;
        totalRate = totalRate + avrageRate ;
      }
      totalRate = totalRate/rates.length ;
      return totalRate;

    } else {
      print(response3.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }


//Customer----------------------------------------------------------------
//Customer----------------------------------------------------------------
  Future<void> registrationCustomer(String userName, String phoneNumber,
      String carMake, String carModel, String carColor) async {
    emit(LoginStarted());
    final response2 = await http.get(
      Uri.parse(
          '$baseUrl${registrationCustomer1}user_name=$userName&phone_number=$phoneNumber&car_make=$carMake&car_model=$carModel&car_color=$carColor'),
      /*       body: {
      'user_name': userName,
      'phone_number': phoneNumber,
      'car_make': carMake,
      'car_model': carModel,
      'car_color': carColor,
    }*/
    );
    if (response2.statusCode == 200) {
      dynamic map = json.decoder.convert(response2.body);
      if (map['result'] == 'successe') {
        print(map['Customer_Cars']);
        print(map['Customer_data']);
        Customer? customer = Customer.fromJsonArray(map['Customer_data']);
        List<Car> cars = Car.fromJsonArray(map['Customer_Cars']);
        customer!.cars = cars;
        this.customer = customer;
        print(customer.id.toString());
        print(customer.id.toString());
        print(customer.id.toString());

        await FirebaseMessaging.instance
            .subscribeToTopic('c'+customer.id.toString());
        await FirebaseMessaging.instance.subscribeToTopic('customers');

     try {
          await FirebaseFirestore.instance
              .collection('DashBoardChats')
              .doc('c' + customer.id.toString())
              .set({
            "provider_id": 'null',
            "customer_id": customer.id.toString(),
            "time": Timestamp.now(),
            "p_name": 'null',
            "c_name": customer.userName,
          });
          await FirebaseFirestore.instance
              .collection('DashBoardChats')
              .doc('c' + customer.id.toString())
              .collection('c' + customer.id.toString())
              .doc(customer.id.toString())
              .set({
            'customer': 'null',
            'support': 'null',
            'time': Timestamp.now(),
            "image_url": "null"
          });
        }catch(e){
       print(e);
     }
        print('-------------------');
        print('-------------------');
        emit(LoginFinishedSuccessfully(
            customer: customer, provider: this.provider));
      } else {
        print(response2.body);
        emit(LoginFinishedWithError());
      }
    } else {
      print(response2.body);
      emit(LoginFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<bool> loginCustomer(
    String phoneNumber,
  ) async {
    emit(LoginStarted());
    final response2 = await http.get(
      Uri.parse('$baseUrl$loginCustomer1 phone_number=$phoneNumber'),
      /*       body: {
      'user_name': userName,
      'phone_number': phoneNumber,
      'car_make': carMake,
      'car_model': carModel,
      'car_color': carColor,
    }*/
    );
    if (response2.statusCode == 200) {
      dynamic map = json.decoder.convert(response2.body);

      if(map['code'] == '200') {
        print(map['Customer_Cars']);
        print(map['Customer_data']);

        Customer? customer = Customer.fromJsonArray2(map['Customer_data']);
        List<Car> cars = Car.fromJsonArray(map['Customer_Cars']);
        customer!.cars = cars;
        this.customer = customer;
        await FirebaseMessaging.instance
            .subscribeToTopic("c" + customer.id.toString());
        await FirebaseMessaging.instance.subscribeToTopic('customers');
        print('-------------------');
        print('-------------------');
        emit(LoginFinishedSuccessfully(
            customer: customer, provider: this.provider));
        return true ;
      }else{
        return false ;
      }
    } else {
      print(response2.body);
      emit(LoginFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<bool> loginCustomer2(
      String phoneNumber,
      ) async {
    //emit(LoginStarted());
    final response2 = await http.get(
      Uri.parse('$baseUrl$loginCustomer1 phone_number=$phoneNumber'),
    );
    if (response2.statusCode == 200) {
      dynamic map = json.decoder.convert(response2.body);

      if(map['code'] == '200') {

        return true ;
      }else{
        return false ;
      }
    } else {
      print(response2.body);
      emit(LoginFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<String> checkPhoneNumber(String phoneNumber) async {
    final response2 = await http.get(
      Uri.parse('$baseUrl${checkPhoneNumber1}phone_number=$phoneNumber'),
    );
    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      return map['result'];
    } else {
      print(response2.body);
      emit(LoginFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<Customer> getCustomerById(String id) async {
    final response3 =
        await http.get(Uri.parse('$baseUrl$getCustomerById1 id=$id'));
    if (response3.statusCode == 200) {
      print(response3.body);
      dynamic map = json.decoder.convert(response3.body);
      print(map['Customer_data']);
      Customer? customer = Customer.fromJsonArray(map['Customer_data']);
      List<Car> cars = Car.fromJsonArray(map['Customer_Cars']);
      customer!.cars = cars;
      this.customer = customer;
      emit(LoginFinishedSuccessfully(customer: customer, provider: provider));
      return customer;
    } else {
      print(response3.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<Customer> getCustomerById2(String id) async {
    final response3 =
        await http.get(Uri.parse('$baseUrl$getCustomerById1 id=$id'));
    if (response3.statusCode == 200) {
      print(response3.body);
      dynamic map = json.decoder.convert(response3.body);
      print(map['Customer_data']);
      Customer? customer = Customer.fromJsonArray(map['Customer_data']);
      List<Car> cars = Car.fromJsonArray(map['Customer_Cars']);
      customer!.cars = cars;
      this.customer = customer;
      return customer;
    } else {
      print(response3.body);
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }
}
