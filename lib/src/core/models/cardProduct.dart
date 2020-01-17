class CardProduct {
  String id;
  String name;
  int quantity;
  String photo;
  int price;

  CardProduct({
    this.id,
    this.name,
    this.quantity,
    this.price,
    this.photo,
  });

  CardProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    quantity = json['quantity'];
  }
}
