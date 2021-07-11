class UserOrder{
  final int userId;
  final int orderId;

  UserOrder({this.userId, this.orderId});

  factory UserOrder.fromJson(Map<String, dynamic> json) {
    return UserOrder(
      userId: json['userId'],
      orderId: json['orderId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId' : this.userId,
      'orderId' : this.orderId
    };
  }

}