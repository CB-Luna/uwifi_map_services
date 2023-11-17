import 'package:google_maps/google_maps.dart' show LatLng;

class CustomerInfo {
  final String street;
  final String city;
  final String state;
  final String zipcode;
  String coverageType;
  String locationGroup;
  final LatLng location;
  String serviceType = 'Residential';
  String? customerRep = '';
  String? origin = '';

  CustomerInfo(
      {required this.street,
      required this.city,
      required this.state,
      required this.zipcode,
      required this.coverageType,
      required this.locationGroup,
      required this.location,
      required this.customerRep,
      required this.origin});
}
