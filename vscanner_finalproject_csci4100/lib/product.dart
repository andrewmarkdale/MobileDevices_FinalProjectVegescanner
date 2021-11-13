class Product {
  final String productName;
  final String barcode;
  final String vegan;
  final String vegetarian;
  var imgB64;
  var notes;
  Product({
    required this.productName,
    required this.barcode,
    required this.vegan,
    required this.vegetarian,
    this.imgB64,
    this.notes,
  });
}
