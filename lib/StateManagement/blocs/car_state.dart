import '../../models/car_make.dart';

abstract class CarDataStates {
  const CarDataStates();
}

class CarDataStateInitial extends CarDataStates {}

class GetCarModelsStarted extends CarDataStates {}

class GetCarModelsFinishedWithError extends CarDataStates {}

class GetCarModelsFinishedSuccessfully extends CarDataStates {
  final List<String>? carModels;
  final List<CarMake>? carMakes;
  GetCarModelsFinishedSuccessfully({
    this.carMakes,
    this.carModels,
  });
}
