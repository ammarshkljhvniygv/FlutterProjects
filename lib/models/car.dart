class Car {
  dynamic id;
  dynamic carMake;
  dynamic carModel;
  dynamic carColor;
  Car({
    required this.id,
    required this.carMake,
    required this.carModel,
    required this.carColor,
  });
  static List<Car> fromJsonArray(dynamic data) {
    List<Car> Cars = [];
    // Map<dynamic>? maps = data;
    for (dynamic map in data) {
      Cars.add(Car(
        id: map["id"],
        carMake: map["car_make"],
        carModel: map["car_model"],
        carColor: map["car_color"],
      ));
    }

    return Cars;
  }
}
