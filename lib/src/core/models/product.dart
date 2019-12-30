class Product {
  String id;
  String name;
  String photo;
  int price;
  String type;
  String rate;
  int quantity;
  String deal;

  Product(
      {this.id,
      this.name,
      this.photo,
      this.price,
      this.type,
      this.rate,
      this.quantity,
      this.deal});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    type = json['type'];
    rate = json['rate'];
    quantity = json['quantity'];
    deal = json['deal'];
  }
}
