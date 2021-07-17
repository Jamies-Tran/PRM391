class SalesReport {
  final String date;
  final String username;
  final String category;
  final String prodCode;
  final String prodName;
  final int price;
  final int qty;
  final int amount;
  final String image;

  SalesReport({this.date, this.username, this.category, this.prodCode, this.prodName, this.price, this.qty, this.amount, this.image});

  factory SalesReport.fromJson(Map<String, dynamic> json) {
    return SalesReport(
        date: json['date'],
        username: json['username'],
        category: json['category'],
        prodCode: json['prodCode'],
        prodName: json['prodName'],
        price: json['price'],
        qty: json['qty'],
        amount: json['amount'],
        image: json['image']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date' : this.date,
      'username' : this.username,
      'category' : this.category,
      'prodCode' : this.prodCode,
      'prodName' : this.prodName,
      'price' : this.price,
      'qty' : this.qty,
      'amount' : this.amount,
      'image' : this.image
    };
  }
}