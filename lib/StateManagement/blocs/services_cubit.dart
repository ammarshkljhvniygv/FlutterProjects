

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:onroad/StateManagement/blocs/services_state.dart';

import '../../constant.dart';
import '../../models/service.dart';


class  ServiceCubit extends Cubit<ServicesStates> {
  ServiceCubit() : super(ServicesStatesInit());

  static ServiceCubit instance(BuildContext context) =>
      BlocProvider.of(context);

  Future<List<Services>> getServices() async{
    emit(GetDataStarted());
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getAllServices',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> services =map;
      List<Services> allServices =[];

      for(int i = 0 ; i < services.length ; i++){
        Services? service = Services.fromJsonArray(services[i]);
        allServices.add(service!);
      }

      emit(GetDataFinishSuccess(services: allServices));
      return allServices ;
    } else {
      print(response2.body);
      emit(GetDataFinishWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }
  Future<List<Services>> getServices2() async{
    final response2 = await http.get(
      Uri.parse(
        '$baseUrl$getAllServices',
      ),
    );
    if (response2.statusCode == 200) {
      print(response2.body);

      dynamic map = json.decoder.convert(response2.body);
      List<dynamic> services =map;
      List<Services> allServices =[];

      for(int i = 0 ; i < services.length ; i++){
        Services? service = Services.fromJsonArray(services[i]);
        allServices.add(service!);
      }

      return allServices ;
    } else {
      print(response2.body);
      emit(GetDataFinishWithError());
      print('error fetching Video model  \n use the no resolution');
      throw (Exception());
    }


  }



}