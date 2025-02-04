class CartItem {
  String productId;
  String productName;
  int quantity = 1;
  double unitPrice;

  CartItem(
      {required this.productId,
      required this.productName,
      required this.unitPrice});

  double calculateTotalPrice() =>
      double.parse((quantity * unitPrice).toStringAsFixed(2));
}
