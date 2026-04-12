import 'package:flutter/material.dart';
import 'order_history_manager.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = OrderHistoryManager.getOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? const Center(
        child: Text("No orders yet"),
      )
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Order #${index + 1}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text("Date: ${order["date"]}"),

                  const Divider(),

                  ...order["items"].map<Widget>((item) {
                    return ListTile(
                      leading: Image.asset(item["image"], width: 40),
                      title: Text(item["title"]),
                      subtitle: Text("Qty: ${item["quantity"]}"),
                      trailing: Text("৳${item["price"]}"),
                    );
                  }).toList(),

                  const Divider(),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Total: ৳${order["total"].toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}