class Favourite {
  String id;
  String productId;
  String userId;

  Favourite({this.id, this.productId, this.userId});

  Favourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['userId'] = this.userId;
    return data;
  }
}
