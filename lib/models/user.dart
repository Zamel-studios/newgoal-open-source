class UserData {
  String? id;
  String? joinDate;
  String? email;
  String? name;
  String? isCertefied;
  String? gender;
  String? weight;
  String? height;
  String? field;
  String? isSubscribed;
  String? profileImg;
  String? status;
  String? password;

  UserData(
      {this.id,
      this.joinDate,
      this.email,
      this.name,
      this.isCertefied,
      this.gender,
      this.weight,
      this.height,
      this.field,
      this.isSubscribed,
      this.profileImg,
      this.status,
      this.password});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joinDate = json['join_date'];
    email = json['email'];
    name = json['name'];
    isCertefied = json['is_certefied'];
    gender = json['gender'];
    weight = json['weight'];
    height = json['height'];
    field = json['field'];
    isSubscribed = json['is_subscribed'];
    profileImg = json['profile_img'];
    status = json['status'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['join_date'] = this.joinDate;
    data['email'] = this.email;
    data['name'] = this.name;
    data['is_certefied'] = this.isCertefied;
    data['gender'] = this.gender;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['field'] = this.field;
    data['is_subscribed'] = this.isSubscribed;
    data['profile_img'] = this.profileImg;
    data['status'] = this.status;
    data['password'] = this.password;
    return data;
  }
}
