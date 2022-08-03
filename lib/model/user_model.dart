/// name : "name"
/// email : "test@gmail.com"
/// uid : "12"

class UserModel {
  UserModel({
    this.name,
    this.email,
    this.uid,
    this.password,
    this.itemCount,
    this.country,
    this.gender,
    this.userid,
    this.birthdate,
  });

  UserModel.fromJson(String mId, dynamic json) {
    print(">>>>> User >>>> $mId");
    name = json['name'];
    email = json['email'];
    uid = mId;
    password = json['password'];
    country = json['country'];
    gender = json['gender'];
    birthdate = json['birthdate'];
    userid = json['userid'];
    itemCount = json['item_Count'];
  }

  String? name;
  String? email;
  String? uid;
  int? itemCount;
  String? password;
  String? country;
  String? gender;
  String? birthdate;
  String? userid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['uid'] = uid;
    map['password'] = password;
    map['item_Count'] = itemCount;
    map['country'] = country;
    map['gender'] = gender;
    map['birthdate'] = birthdate;
    map['userid'] = userid;
    return map;
  }
}
