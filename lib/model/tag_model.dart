/// uid : ""
/// name : "tushar"
/// date : ""

class TagModel {
  TagModel({
    this.uid,
    this.userid,
    this.tagItemCount,
    this.name,
    this.date,
  });

  TagModel.fromJson(String mId, dynamic json) {
    print(">>>>> Box >>>> $mId");
    uid = mId;
    userid = json['userid'];
    name = json['name'];
    tagItemCount = json['tagItemCount'];
    // try {
    //   name = json['name'] != null ? json['name'].toString().split(",") : [];
    // } on Exception catch (e) {
    //   name = [];
    //   // TODO
    // }
    date = json['date'];
  }

  TagModel.fromDb(dynamic json) {
    uid = json['uid'];
    userid = json['userid'];
    name = json['name'];
    tagItemCount = json['tagItemCount'];
    // try {
    //   name = json['name'] != null ? json['name'].toString().split(",") : [];
    // } on Exception catch (e) {
    //   name = [];
    //   // TODO
    // }
    date = json['date'];
  }

  String? uid;
  String? userid;
  int? tagItemCount;
  String? name;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['userid'] = userid;
    map['tagItemCount'] = tagItemCount;
    map['name'] = name;
    // map['name'] = name?.join(",");
    map['date'] = date;
    return map;
  }
}
