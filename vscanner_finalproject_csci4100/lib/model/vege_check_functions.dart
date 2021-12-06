import 'package:vscanner_finalproject_csci4100/model/product.dart';
import 'package:flutter/material.dart';

// These important functions check which icon to use for the various pages.
String veganCheck(Product product) {
  if (product.vegan == "yes" || product.vegan == "images/vegan_icon_true.png") {
    return "images/vegan_icon_true.png";
  } else if (product.vegan == "maybe-vegan" ||
      product.vegan == "images/vegan_icon_maybe.png") {
    return "images/vegan_icon_maybe.png";
  } else if (product.vegan == "non-vegan" ||
      product.vegan == "images/vegan_icon_false.png") {
    return "images/vegan_icon_false.png";
  } else {
    return "images/vegan_icon_false_unknown.png";
  }
}

String strVeganCheck(String vegan) {
  if (vegan == "yes" || vegan == "images/vegan_icon_true.png") {
    return "images/vegan_icon_true.png";
  } else if (vegan == "maybe-vegan" || vegan == "images/vegan_icon_maybe.png") {
    return "images/vegan_icon_maybe.png";
  } else if (vegan == "non-vegan" || vegan == "images/vegan_icon_false.png") {
    return "images/vegan_icon_false.png";
  } else {
    return "images/vegan_icon_false_unknown.png";
  }
}

String vegetarianCheck(Product product) {
  if (product.vegetarian == "yes" ||
      product.vegetarian == "images/vegetarian_icon_true.png") {
    return "images/vegetarian_icon_true.png";
  } else if (product.vegetarian == "maybe-vegetarian" ||
      product.vegetarian == "images/vegetarian_icon_maybe.png") {
    return "images/vegetarian_icon_maybe.png";
  } else if (product.vegetarian == "non-vegetarian" ||
      product.vegetarian == "images/vegetarian_icon_false.png") {
    return "images/vegetarian_icon_false.png";
  } else {
    return "images/vegetarian_icon_unknown.png";
  }
}

String strVegetarianCheck(String vegetarian) {
  if (vegetarian == "yes" || vegetarian == "images/vegetarian_icon_true.png") {
    return "images/vegetarian_icon_true.png";
  } else if (vegetarian == "maybe-vegetarian" ||
      vegetarian == "images/vegetarian_icon_maybe.png") {
    return "images/vegetarian_icon_maybe.png";
  } else if (vegetarian == "non-vegetarian" ||
      vegetarian == "images/vegetarian_icon_false.png") {
    return "images/vegetarian_icon_false.png";
  } else {
    return "images/vegetarian_icon_false.png";
  }
}
