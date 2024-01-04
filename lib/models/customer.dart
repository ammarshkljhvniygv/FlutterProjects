import 'package:onroad/models/car.dart';

class Customer {
  dynamic id;
  dynamic userName;
  dynamic phoneNumber;
  bool isActive;
  List<Car>? cars;
  Customer({
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.isActive,
    this.cars,
  });
  static Customer? fromJsonArray2(dynamic data) {
    Customer? customer;
    // Map<String,dynamic>? maps = data;
    customer = Customer(
      id: data["id"],
      userName: data["user_name"],
      phoneNumber: data["phone_number"],
      isActive: data["active"] == 1 ? true : false,

    );
    return customer;
  }
  static Customer? fromJsonArray(dynamic data) {
    Customer? customer;
    // Map<String,dynamic>? maps = data;
    customer = Customer(
      id: data[0]["id"],
      userName: data[0]["user_name"],
      phoneNumber: data[0]["phone_number"],
      isActive: data[0]["active"] == 1 ? true : false,

    );
    return customer;
  }
}
