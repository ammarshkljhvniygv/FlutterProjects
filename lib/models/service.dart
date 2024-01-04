

class Services {
  dynamic id;
  dynamic enName;
  dynamic arName;
  dynamic enText;
  dynamic arText;
  dynamic cost;

  Services({this.id, this.enName, this.arName, this.enText, this.arText, this.cost});


  static Services? fromJsonArray(dynamic data) {
    Services? service;
    // Map<String,dynamic>? maps = data;
    service = Services(
      id: data["id"],
      enName: data["en_name"],
      arName: data["ar_name"],
      enText: data["en_text1"],
      arText: data["ar_text1"],
      cost: data["service_cost"],
    );
    return service;
  }

}