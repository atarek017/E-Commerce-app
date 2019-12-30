class User {
  String id;
  String name;
  String email;
  String password;
  String photo;
  String address;
  String phone;
  String verify;
  String isVerifyed;

  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.photo,
      this.address,
      this.phone,
      this.verify,
      this.isVerifyed});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    photo = json['photo'];
    address = json['address'];
    phone = json['phone'];
    verify = json['verify'];
    isVerifyed = json['isverifyed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['photo'] = this.photo;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['verify'] = this.verify;
    data['isverifyed'] = this.isVerifyed;
    return data;
  }
}
