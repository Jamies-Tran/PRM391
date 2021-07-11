class Product {
  final int id;
  final String name;
  final String code;
  final String category;
  final int price;
  final int stock;
  final String image;

  Product({this.id, this.name, this.code, this.category, this.price, this.stock, this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      category: json['category'],
      price: json['price'],
      stock: json['stock'],
      image: json['image']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : this.id,
      'name' : this.name,
      'code' : this.code,
      'category' : this.category,
      'price' : this.price,
      'stock' : this.stock,
      'image' : this.image
    };
  }

}