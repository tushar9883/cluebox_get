/// userid : ""
/// uid : ""
/// name : ""
/// gender : ""
/// country : ""
/// date_birth : ""
/// date  : ""

class UserinfoModel {
  UserinfoModel({
    this.userid,
    this.uid,
    this.name,
    this.gender,
    this.country,
    this.dateBirth,
    this.date,
  });

  UserinfoModel.fromJson(String mId, dynamic json) {
    print(">>>>> Userinfo >>>> $mId");
    userid = json['userid'];
    uid = mId;
    name = json['name'];
    gender = json['gender'];
    country = json['country'];
    dateBirth = json['date_birth'];
    date = json['date '];
  }
  String? userid;
  String? uid;
  String? name;
  String? gender;
  String? country;
  String? dateBirth;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userid'] = userid;
    map['uid'] = uid;
    map['name'] = name;
    map['gender'] = gender;
    map['country'] = country;
    map['date_birth'] = dateBirth;
    map['date '] = date;
    return map;
  }
}
