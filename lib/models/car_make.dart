import 'dart:convert';

class CarMake{
  dynamic id ;
  dynamic name ;
  CarMake(
      {this.id,
        this.name,
      });


  static List<CarMake> fromJsonArray(dynamic data) {
    List<CarMake> product = [];
    List<dynamic>? maps = json.decoder.convert(data);
    if(maps != null) {
      for (dynamic map in maps) {
          product.add(CarMake(
            id: map["id"],
            name: map["name"],

          ));

      }
    }
    return product;
  }

}