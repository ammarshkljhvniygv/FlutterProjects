import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:onroad/StateManagement/blocs/login_cubit.dart';
import 'package:onroad/constant.dart';
import 'package:onroad/models/car.dart';
import 'package:onroad/models/customer.dart';
import 'package:onroad/models/provider.dart';

import 'update_profil_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileStateInitial());

  static UpdateProfileCubit instance(BuildContext context) =>
      BlocProvider.of(context);
  Customer? customer;
  Provider? provider;
  Future<String?> updateProviderProfile(
      dynamic id,
      String userName,
      String phoneNumber,
      String email,
      String password,
      bool license,
      bool repairShop,
      String carNumber,
      String workType,
      List<dynamic> services1,
      BuildContext context) async {
    LoginCubit loginCubit = LoginCubit.instance(context);
    emit(UpdateProfileStarted());
    final response2 =
        await http.post(Uri.parse('$baseUrl$updateProviderAccount'),
            headers: {"Content-Type": "application/json"},
            body: utf8.encode(json.encode({
              'id': id,
              'user_name': userName,
              'phone_number': phoneNumber,
              'password': password,
              'repair_shop': repairShop ? 1 : 0,
              'license': license ? 1 : 0,
              'work_type': workType,
              'email': email,
              // 'car_number': carNumber,
              'servises': services1,
            })));
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      print(map['provider_data']);
      print(map['Services_ids']);
      if (map['code'] == '400') {
        Provider provider = await loginCubit.getProviderById(id.toString());
/*        Provider provider = Provider(
            id: id,
            workType: workType,
            email: email,
            license: license,
            userName: userName,
            phoneNumber: phoneNumber,
            repairShop: repairShop,
            carNumber: carNumber,
            password: password);
        provider.services = services1;*/
        emit(UpdateProfileSuccessfully(customer: customer, provider: provider,result: map['result']));
        return map['result'];
      }
      Provider? provider = Provider.fromJsonArray(map['provider_data']);
      List<dynamic> services = map['Services_ids'];
      /*List<dynamic> servicesIds = [];
      for (int i = 0; i < services.length; i++) {
        servicesIds.add(services[i]['service_id']);
      }*/
      provider!.services = services;
      this.provider = provider;
      emit(UpdateProfileSuccessfully(
          customer: customer, provider: this.provider,result: null));
      return null;
    } else {
      print(response2.body);
      emit(UpdateProfileFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<bool> deleteProviderAccount(String id) async {
    emit(UpdateProfileStarted());
    final response2 =
        await http.get(Uri.parse('$baseUrl$deleteProviderAccount1 id=$id'));
    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      print(map['result']);
      if (map['result'] == 'successe') {
        emit(UpdateProfileStateInitial());
        return true;
      } else {
        emit(UpdateProfileStateInitial());
        return false;
      }
    } else {
      print(response2.body);
      emit(UpdateProfileFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<bool> updateProviderAccountState(String id , bool state) async{
    // emit(GetDataStartedP());
    final response2 = await http.post(
        Uri.parse(
          '$baseUrl$updateProviderAccountState1',
        ),
        body: {
          'id': id,
          'state': state?'1':'0',
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
    } else {
      print(response2.body);
      //   emit(GetDataFinishWithErrorP());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }


///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

  Future<void> updateCustomerProfile(String customerId, String userName,
      String phoneNumber, List<Car> cars) async {
    emit(UpdateProfileStarted());
    final response2 =
        await http.post(Uri.parse('$baseUrl$updateCustomerAccount1'), body: {
      'id': customerId,
      'user_name': userName,
      'phone_number': phoneNumber,
    });
    if (response2.statusCode == 200) {
      print(response2.body);

      for (int i = 0; i < cars.length; i++) {
        final response =
            await http.post(Uri.parse('$baseUrl$addCustomerCar1'), body: {
          'customer_id': customerId,
          'car_make': cars[i].carMake,
          'car_model': cars[i].carModel,
          'car_color': cars[i].carColor,
        });
        if (response2.statusCode == 200) {
          print(response.body);
        } else {
          print(response2.body);
          emit(UpdateProfileFinishedWithError());
          print('error fetching Video model  \n use the no resolution');
          throw (Exception());
        }
      }
      final response3 =
          await http.get(Uri.parse('$baseUrl$getCustomerById1 id=$customerId'));
      if (response3.statusCode == 200) {
        print(response3.body);
        dynamic map = json.decoder.convert(response3.body);
        print(map['Customer_Cars']);
        Customer? customer = Customer.fromJsonArray(map['Customer_data']);
        List<Car> cars = Car.fromJsonArray(map['Customer_Cars']);
        customer!.cars = cars;
        emit(UpdateProfileSuccessfully(customer: customer, provider: provider));
      } else {
        print(response2.body);
        emit(UpdateProfileFinishedWithError());
        print('error fetching Video model  \n use the no resolution');
        throw (Exception());
      }
    } else {
      print(response2.body);
      emit(UpdateProfileFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<void> addCustomerCar(String customerId, String carMake,
      String carModel, String carColor) async {
    // emit(LoginStarted());
    final response2 =
        await http.post(Uri.parse('$baseUrl$addCustomerCar1'), body: {
      'customer_id': customerId,
      'car_make': carMake,
      'car_model': carModel,
      'car_color': carColor,
    });
    if (response2.statusCode == 200) {
      dynamic map = json.decoder.convert(response2.body);
      /*   print(map['Customer_Cars']);
      Customer? customer = Customer.fromJsonArray(map['Customer_data']);
      List<Car> cars = Car.fromJsonArray(map['Customer_Cars']);
      customer!.cars = cars;*/
      // emit(LoginFinishedSuccessfully(customer: customer));
    } else {
      print(response2.body);
      emit(UpdateProfileFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<void> deleteCustomerCar(String customerId, String carId) async {
    emit(UpdateProfileStarted());
    final response2 = await http.get(Uri.parse(
        '$baseUrl$deleteCustomerCar1 customer_id=$customerId&&id=$carId'));
    if (response2.statusCode == 200) {
      print(response2.body);
      final response3 =
          await http.get(Uri.parse('$baseUrl$getCustomerById1 id=$customerId'));
      if (response3.statusCode == 200) {
        print(response3.body);
        dynamic map = json.decoder.convert(response3.body);
        print(map['Customer_Cars']);
        Customer? customer = Customer.fromJsonArray(map['Customer_data']);
        List<Car> cars = Car.fromJsonArray(map['Customer_Cars']);
        customer!.cars = cars;
        emit(UpdateProfileSuccessfully(customer: customer, provider: provider));
      } else {
        print(response2.body);
        emit(UpdateProfileFinishedWithError());
        print('error fetching Video model  \n use the no resolution');
        throw (Exception());
      }
    } else {
      print(response2.body);
      emit(UpdateProfileFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<bool> deleteCustomerAccount(String customerId) async {
    emit(UpdateProfileStarted());
    final response2 = await http
        .get(Uri.parse('$baseUrl$deleteCustomerAccount1 id=$customerId'));
    if (response2.statusCode == 200) {
      print(response2.body);
      dynamic map = json.decoder.convert(response2.body);
      print(map['result']);
      if (map['result'] == 'successe') {
        emit(UpdateProfileStateInitial());
        return true;
      } else {
        emit(UpdateProfileStateInitial());

        return false;
      }
    } else {
      print(response2.body);
      emit(UpdateProfileFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<bool> updateCustomerAccountState(String id , bool state) async{
    // emit(GetDataStartedP());
    final response2 = await http.post(
        Uri.parse(
          '$baseUrl$updateCustomerAccountState1',
        ),
        body: {
          'id': id,
          'state': state?'1':'0',
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
    } else {
      print(response2.body);
      //   emit(GetDataFinishWithErrorP());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }


}
