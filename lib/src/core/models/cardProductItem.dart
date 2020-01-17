class CardProductItem {
  String id;
  int quantity;
  String productId;
  String userId;

  CardProductItem({
    this.id,
    this.quantity,
    this.productId,
    this.userId,
  });

  CardProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    userId = json['userId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['productId'] = this.productId;
    data['userId'] = this.userId;

    return data;
  }

}
