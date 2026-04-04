import 'product_model.dart';

class WishlistManager {
  static List<Product> wishlistItems = [];

  static bool isInWishlist(Product product) {
    return wishlistItems.any((item) => item.title == product.title);
  }

  static void toggleWishlist(Product product) {
    if (isInWishlist(product)) {
      wishlistItems.removeWhere((item) => item.title == product.title);
    } else {
      wishlistItems.add(product);
    }
  }
}