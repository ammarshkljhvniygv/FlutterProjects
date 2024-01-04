import 'package:google_maps_flutter/google_maps_flutter.dart';

class Provider {
  dynamic id;
  dynamic userName;
  dynamic phoneNumber;
  String email;
  String password;
  String carNumber;
  String workType;
  String? time;
  String? distance;
  double? distance2;
  bool license;
  bool repairShop;
  List<dynamic>? services;
  LatLng? providerLocation;
  bool isActive;
  double rate;

  Provider({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    required this.license,
    required this.repairShop,
    required this.carNumber,
    required this.workType,
    required this.phoneNumber,
    required this.isActive,
    this.services,
    this.providerLocation,
    this.time,
    this.distance,
    this.rate = 0,
  });
  static Provider? fromJsonArray(dynamic data) {
    Provider? provider;
    // Map<String,dynamic>? maps = data;
    provider = Provider(
      id: data[0]["id"],
      userName: data[0]["user_name"],
      phoneNumber: data[0]["phone_number"],
      email: data[0]["email"],
      license: data[0]["license"] == 1 ? true : false,
      workType: data[0]["work_type"],
      carNumber: data[0]["car_number"],
      password: data[0]["password"],
      repairShop: data[0]["repair_shop"] == 1 ? true : false,
      isActive: data[0]["active"] == 1 ? true : false,
    );
    return provider;
  }
  static Provider? fromJsonArray2(dynamic data) {
    Provider? provider;
    // Map<String,dynamic>? maps = data;
    provider = Provider(
        id: data["id"],
        userName: data["user_name"],
        phoneNumber: data["phone_number"],
        email: data["email"],
        license: data["license"] == 1 ? true : false,
        workType: data["work_type"],
        carNumber: data["car_number"],
        password: data["password"],
        repairShop: data["repair_shop"] == 1 ? true : false,
        isActive: data["active"] == 1 ? true : false,
        providerLocation: LatLng(data["lat"]==null?0:double.parse(data["lat"].toString()),data["lng"]==null?0:double.parse(data["lng"].toString()))
    );
    return provider;
  }

}
