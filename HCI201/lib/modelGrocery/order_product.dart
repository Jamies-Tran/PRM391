class OrderProduct {
  final int productId;
  final int orderId;
  final int totalPrice;
  final int quantity;

  OrderProduct({this.orderId, this.productId, this.quantity, this.totalPrice});

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      orderId: json['orderId'],
      productId: json['productId'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId' : this.orderId,
      'productId' : this.productId,
      'quantity' : this.quantity,
      'totalPrice' : this.totalPrice
    };
  }

}