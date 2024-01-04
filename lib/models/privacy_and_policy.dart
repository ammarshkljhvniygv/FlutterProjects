

class PrivacyAndPolicy{
  dynamic id ;
  dynamic enText ;
  dynamic arText ;

  PrivacyAndPolicy({this.id, this.enText, this.arText});

  static PrivacyAndPolicy? fromJsonArray(dynamic data) {
    PrivacyAndPolicy? privacyAndPolicy;
    // Map<String,dynamic>? maps = data;
    privacyAndPolicy = PrivacyAndPolicy(
      id: data["id"],
      arText: data["ar_text"],
      enText: data["en_text"],
    );
    return privacyAndPolicy;
  }
}