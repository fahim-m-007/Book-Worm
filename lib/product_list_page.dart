import 'package:flutter/material.dart';
import 'product_model.dart';
import 'product_details_page.dart';
import 'book_data.dart';

class ProductListPage extends StatefulWidget {
  final String sectionName;

  const ProductListPage({
    super.key,
    required this.sectionName,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  String selectedSort = "None";
  late List<Product> products;

  @override
  void initState() {
    super.initState();
    products = List.from(bookDatabase[widget.sectionName] ?? []);
  }

  void sortProducts(String value) {
    setState(() {
      selectedSort = value;

      if (value == "Low to High") {
        products.sort((a, b) => a.price.compareTo(b.price));
      } else if (value == "High to Low") {
        products.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sectionName),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: sortProducts,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Low to High",
                child: Text("Price: Low → High"),
              ),
              const PopupMenuItem(
                value: "High to Low",
                child: Text("Price: High → Low"),
              ),
            ],
            icon: const Icon(Icons.sort),
          ),
        ],
      ),

      body: products.isEmpty
          ? const Center(
        child: Text(
          "No books available in this section.",
          style: TextStyle(fontSize: 16),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {

          final product = products[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(product: product),
                ),
              );
            },
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600),
                ),

                Text(
                  product.author,
                  style: const TextStyle(
                      color: Colors.grey),
                ),

                Text(
                  "৳${product.price}",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}