/// uid : ""
/// name : "tushar"
/// date : ""

class TagModel {
  TagModel({
    this.uid,
    this.userid,
    this.name,
    this.date,
  });

  TagModel.fromJson(String mId, dynamic json) {
    print(">>>>> Box >>>> $mId");
    uid = mId;
    userid = json['userid'];
    name = json['name'];
    date = json['date'];
  }
  String? uid;
  String? userid;
  String? name;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['userid'] = userid;
    map['name'] = name;
    map['date'] = date;
    return map;
  }
}
