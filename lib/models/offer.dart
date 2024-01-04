

class Offer{
  dynamic id ;
  dynamic enOffer ;
  dynamic arOffer ;
  dynamic enOfferTitle ;
  dynamic arOfferTitle ;

  Offer(
      {this.id,
        this.enOffer,
        this.arOffer,
        this.enOfferTitle,
        this.arOfferTitle});

  static Offer? fromJsonArray(dynamic data) {
    Offer? offer;
    // Map<String,dynamic>? maps = data;
    offer = Offer(
      id: data["id"],
      enOffer: data["offer_title_en"],
      arOffer: data["offer_title_ar"],
      arOfferTitle: data["offer_ar"],
      enOfferTitle: data["offer_en"],

    );
    return offer;
  }
}