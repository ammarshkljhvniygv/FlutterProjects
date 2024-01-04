import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../models/car_make.dart';
import 'car_state.dart';

class CarDataCubit extends Cubit<CarDataStates> {
  CarDataCubit() : super(CarDataStateInitial());

  static CarDataCubit instance(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getCarMakes() async {
    emit(GetCarModelsStarted());
    const String url = 'https://car-specs.p.rapidapi.com/v2/cars/makes';
    final response2 = await http.get(Uri.parse(url), headers: {
      "X-RapidAPI-Key": "72b4369a85mshb644b6b25fa5193p1b1e04jsn95c51fc919e7",
      "X-RapidAPI-Host": "car-specs.p.rapidapi.com",
    });
    if (response2.statusCode == 200) {
      print('------------');
      final List<CarMake> carMakes = CarMake.fromJsonArray(response2.body);
      emit(GetCarModelsFinishedSuccessfully(carMakes: carMakes));
    } else {
      print(response2.body);
      emit(GetCarModelsFinishedWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }
  }

  Future<void> getCarModelsByCarMake(String carMakeId) async {
    emit(GetCarModelsStarted());
    // print(carMake);
    List<String> carModels = [];

    for (int i = 0; i < 1; i++) {
      String url =
          'https://car-specs.p.rapidapi.com/v2/cars/makes/$carMakeId/models?';
      final response2 = await http.get(Uri.parse(url), headers: {
        "X-RapidAPI-Key": "72b4369a85mshb644b6b25fa5193p1b1e04jsn95c51fc919e7",
        "X-RapidAPI-Host": "car-specs.p.rapidapi.com",
      });
      if (response2.statusCode == 200) {
        List<dynamic> carModels2 = [];
        if (response2.body != null) {
          print(response2.body);
          carModels2 = json.decoder.convert(response2.body);
        }
        /* if(carModels!  ) {
           carModels = carModels2;
         }*/
        for (int j = 0; j < carModels2.length; j++) {
          print(carModels2[j]['name']);
          carModels.add(carModels2[j]['name'].toString());
          // carModels!.add(carModels2[j]);
        }
      } else {
        print(response2.body);

        emit(GetCarModelsFinishedWithError());
        print('error fetching Video model  \n use the no resolution');
        throw (Exception());
      }
    }
    print('------------------------------------------------------');
    print(carModels.length);

    emit(GetCarModelsFinishedSuccessfully(carModels: carModels));
  }
}
