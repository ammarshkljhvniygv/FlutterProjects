


class CommonQuestion{
  dynamic id ;
  dynamic enQuestion ;
  dynamic arQuestion ;
  dynamic enAnswer ;
  dynamic arAnswer ;

  CommonQuestion(
      {this.id,
      this.enQuestion,
      this.arQuestion,
      this.enAnswer,
      this.arAnswer});

  static CommonQuestion? fromJsonArray(dynamic data) {
    CommonQuestion? commonQuestion;
    // Map<String,dynamic>? maps = data;
    commonQuestion = CommonQuestion(
      id: data["id"],
      arQuestion: data["ar_question"],
      enQuestion: data["en_question"],
      arAnswer: data["ar_anser"],
      enAnswer: data["en_anser"],

    );
    return commonQuestion;
  }
}