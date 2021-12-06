// Basic product class, used to hold the information gained from the API calls
// is then stored in the DB.

// productName is the name of the item
// barcode is the barcode
// Vegan is whether the item is vegan (json response)
// Vegetarian is whether the item is vegetarian (json response)
// imgb64 is the map image data converted to a string
// Notes is the notes the user stores.

class Product {
  String productName;
  String barcode;
  String vegan;
  String vegetarian;
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
