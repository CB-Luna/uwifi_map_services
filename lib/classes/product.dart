class Product {
  final String id;
  final String name;
  final double cost;
  double subtotal;
  String imageurl;
  final String service;
  final String description; //tipo de producto
  int? index;
  bool? isSelected;
  int quantity = 1;
  String pwName = "";
  List<String>? groups = [];

  Product({
    required this.id,
    required this.name,
    required this.cost,
    this.subtotal = 0.0,
    required this.imageurl,
    required this.service,
    required this.description,
    this.index,
    this.isSelected,
    required this.quantity,
    required this.pwName,
    this.groups,
  });

  Product copyWith({
    String? id,
    String? name,
    double? cost,
    double? subtotal,
    String? imageurl,
    String? service,
    String? description,
    int? index,
    bool? isSelected,
    int? quantity,
    String? pwName,
    List<String>? groups,
    bool? carousel
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      subtotal: subtotal ?? this.subtotal,
      imageurl: imageurl ?? this.imageurl,
      service: service ?? this.service,
      description: description ?? this.description,
      index: index ?? this.index,
      isSelected: isSelected ?? this.isSelected,
      quantity: quantity ?? this.quantity,
      pwName: pwName ?? this.pwName,
      groups: groups ?? this.groups
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'name': name,
      'description': service,
      'family': description,
      'price': cost.toString(),
      'quantity': quantity.toString(),
      'pwName': pwName
    };
  }
}
