import 'package:flutter/material.dart';
import 'wishlist_manager.dart';
import 'product_details_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {

  @override
  Widget build(BuildContext context) {
    final wishlistItems = WishlistManager.wishlistItems;

    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist (${wishlistItems.length})"),
      ),
      body: wishlistItems.isEmpty
          ? const Center(
        child: Text("No items in wishlist"),
      )
          : ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final product = wishlistItems[index];

          return Card(
            margin: const EdgeInsets.all(5),
            child: ListTile(
              leading: Image.asset(product.image, width: 50),
              title: Text(product.title),
              subtitle: Text("৳${product.price}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    WishlistManager.toggleWishlist(product);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Removed from Wishlist"),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailsPage(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}