class Product {
  final String id;
  final String name;
  final double cost;
  String? imageurl;
  final String service;
  final String category; //tipo de producto
  int? index;
  bool? isSelected;
  int quantity = 1;
  String pwName = "";
  List<String>? groups = [];

  Product({
    required this.id,
    required this.name,
    required this.cost,
    this.imageurl,
    required this.service,
    required this.category,
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
    String? imageurl,
    String? service,
    String? category,
    int? index,
    bool? isSelected,
    int? quantity,
    String? pwName,
    List<String>? groups,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
      imageurl: imageurl ?? this.imageurl,
      service: service ?? this.service,
      category: category ?? this.category,
      index: index ?? this.index,
      isSelected: isSelected ?? this.isSelected,
      quantity: quantity ?? this.quantity,
      pwName: pwName ?? this.pwName,
      groups: groups ?? this.groups,
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id,
      'name': name,
      'category': service,
      'family': category,
      'price': cost.toString(),
      'quantity': quantity.toString(),
      'pwName': pwName
    };
  }
}
