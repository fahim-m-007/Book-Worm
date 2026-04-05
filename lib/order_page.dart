import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double subtotal;
  final double shipping;
  final double total;

  const OrderPage({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.shipping,
    required this.total,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void confirmOrder() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Order Confirmed"),
          content: const Text("Your order has been placed successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, true);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Widget buildInputField({
    required String label,
    required TextEditingController controller,
    String? validationMessage,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (value) {
          if (validationMessage != null) {
            if (value == null || value.trim().isEmpty) {
              return validationMessage;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget summaryRow(String title, String value, {bool isBold = false}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget buildCartItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(item["image"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Quantity: ${item["quantity"]}",
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "৳${item["price"]}",
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EDF3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3EDF3),
        elevation: 0,
        title: const Text(
          "Order Page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    "Delivery Information",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  buildInputField(
                    label: "Full Name",
                    controller: nameController,
                    validationMessage: "Please enter your name",
                  ),
                  buildInputField(
                    label: "Phone Number",
                    controller: phoneController,
                    validationMessage: "Please enter your phone number",
                    keyboardType: TextInputType.phone,
                  ),
                  buildInputField(
                    label: "Shipping Address",
                    controller: addressController,
                    validationMessage: "Please enter your address",
                    maxLines: 3,
                  ),
                  buildInputField(
                    label: "Order Note (Optional)",
                    controller: noteController,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Ordered Items",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...widget.cartItems.map((item) => buildCartItem(item)).toList(),
                  const SizedBox(height: 10),
                  const Text(
                    "Payment Summary",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        summaryRow(
                          "Subtotal",
                          "৳${widget.subtotal.toStringAsFixed(0)}",
                        ),
                        const SizedBox(height: 10),
                        summaryRow(
                          "Shipping",
                          "৳${widget.shipping.toStringAsFixed(0)}",
                        ),
                        const Divider(height: 24),
                        summaryRow(
                          "Total",
                          "৳${widget.total.toStringAsFixed(0)}",
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFE5E5E5),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: confirmOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF443A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Confirm Order ৳${widget.total.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}