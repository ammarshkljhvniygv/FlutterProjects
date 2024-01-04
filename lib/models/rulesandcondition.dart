

class RuleAndConditions{

  dynamic id ;
  dynamic enText ;
  dynamic arText ;

  RuleAndConditions({this.id, this.enText, this.arText});

  static RuleAndConditions? fromJsonArray(dynamic data) {
    RuleAndConditions? ruleAndConditions;
    // Map<String,dynamic>? maps = data;
    ruleAndConditions = RuleAndConditions(
      id: data["id"],
      arText: data["ar_text"],
      enText: data["en_text"],
    );
    return ruleAndConditions;
  }
}