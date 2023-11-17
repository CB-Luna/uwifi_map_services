class QueryParams {
  String? street;
  String? zipcode;
  String? customerRep;
  String? origin;
  bool? isAddress;

  static QueryParams? _instance;

  static QueryParams? get instance => _instance;

  QueryParams._address({this.street, this.zipcode});

  QueryParams._customerRep({this.customerRep});

  QueryParams._origin({this.origin});

  factory QueryParams.initAddress(street, zipcode) {
    if (_instance == null) {
      _instance = QueryParams._address(street: street, zipcode: zipcode);
    } else {
      _instance!.street = street;
      _instance!.zipcode = zipcode;
    }
    _instance!.isAddress = true;
    return _instance!;
  }

  factory QueryParams.initCustomerRep(String customerRep) {
    if (_instance == null) {
      _instance = QueryParams._customerRep(customerRep: customerRep);
    } else {
      _instance!.customerRep = customerRep;
    }
    return _instance!;
  }

  factory QueryParams.initOrigin(String origin) {
    if (_instance == null) {
      _instance = QueryParams._origin(origin: origin);
    } else {
      _instance!.origin = origin;
    }
    return _instance!;
  }
}
