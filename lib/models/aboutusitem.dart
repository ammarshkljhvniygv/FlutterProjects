


class AboutAsItem{

  dynamic id;
  dynamic arTitle;
  dynamic enTitle;
  dynamic arBody;
  dynamic enBody;

  AboutAsItem({this.id,this.arTitle, this.enTitle, this.arBody, this.enBody});

  static AboutAsItem? fromJsonArray(dynamic data) {
    AboutAsItem? aboutAsItem;
    // Map<String,dynamic>? maps = data;
    aboutAsItem = AboutAsItem(
      id: data["id"],
      arTitle: data["ar_title"],
      enTitle: data["en_title"],
      arBody: data["ar_body"],
      enBody: data["en_body"],

    );
    return aboutAsItem;
  }

}