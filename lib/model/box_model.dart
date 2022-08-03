/// uid : ""
/// name : "tushar"
/// date : ""
/// location_id : ""
/// location_name : ""

class BoxModel {
  BoxModel({
    this.uid,
    this.userid,
    this.name,
    this.date,
    this.locationId,
    this.locationName,
  });

  BoxModel.fromJson(String mId, dynamic json) {
    print(">>>>> Box >>>> $mId");
    uid = mId;
    userid = json['userid'];
    name = json['name'];
    date = json['date'];
    locationId = json['location_id'];
    locationName = json['location_name'];
  }

  BoxModel.fromDB(dynamic json) {
    uid = json['uid'];
    userid = json['userid'];
    name = json['name'];
    date = json['date'];
    locationId = json['location_id'];
    locationName = json['location_name'];
  }

  String? uid;
  String? userid;
  String? name;
  String? date;
  String? locationId;
  String? locationName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['userid'] = userid;
    map['name'] = name;
    map['date'] = date;
    map['location_id'] = locationId;
    map['location_name'] = locationName;
    return map;
  }
}
