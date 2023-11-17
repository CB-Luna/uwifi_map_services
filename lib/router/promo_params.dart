class PromoParams {

  String? promo;

  static PromoParams? _instance;

  static PromoParams? get instance => _instance;

  PromoParams._promoRep({this.promo});

  factory PromoParams.initPromoRep(String promo) {
    if (_instance == null) {
      _instance = PromoParams._promoRep(promo: promo);
    } else {
      _instance!.promo = promo;
    }
    return _instance!;
  }

}
