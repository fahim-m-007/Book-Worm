class OrderHistoryManager {
  static List<Map<String, dynamic>> orders = [];

  static void addOrder(Map<String, dynamic> order) {
    orders.add(order);
  }

  static List<Map<String, dynamic>> getOrders() {
    return orders;
  }
}