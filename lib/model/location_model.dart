/// name : "tushar"
/// uid : ""
/// date : ""

class LocationModel {
  LocationModel({
    this.name,
    this.userid,
    this.uid,
    this.date,
  });

  LocationModel.fromJson(String mId, dynamic json) {
    print(">>>>> Location >>>> $mId");
    name = json['name'];
    userid = json['userid'];
    uid = uid = mId;
    date = json['date'];
  }
  String? name;
  String? userid;
  String? uid;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['userid'] = userid;
    map['uid'] = uid;
    map['date'] = date;
    return map;
  }
}
