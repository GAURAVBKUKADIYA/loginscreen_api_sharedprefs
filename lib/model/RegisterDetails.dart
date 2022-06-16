class RegisterDetail {
  String id;
  String name;
  String email;
  String userimage;
  String address;
  String gender;
  Phone phone;

  RegisterDetail(
      {this.id,
        this.name,
        this.email,
        this.userimage,
        this.address,
        this.gender,
        this.phone});

  RegisterDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userimage = json['userimage'];
    address = json['address'];
    gender = json['gender'];
    phone = json['phone'] != null ? new Phone.fromJson(json['phone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userimage'] = this.userimage;
    data['address'] = this.address;
    data['gender'] = this.gender;
    if (this.phone != null) {
      data['phone'] = this.phone.toJson();
    }
    return data;
  }
}

class Phone {
  String mobile;
  String home;

  Phone({this.mobile, this.home});

  Phone.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    home = json['home'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['home'] = this.home;
    return data;
  }
}