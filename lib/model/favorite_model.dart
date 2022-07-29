/// userid : ""
/// uid : ""
/// item_name : ""
/// location_id : ""
/// location_name : ""
/// box_id : ""
/// box_name : ""
/// image : ""
/// date  : ""

class FavoriteModel {
  FavoriteModel({
    this.userid,
    this.uid,
    this.itemName,
    this.locationId,
    this.locationName,
    this.boxId,
    this.boxName,
    this.image,
    this.date,
  });

  FavoriteModel.fromJson(String mId, dynamic json) {
    print(">>>>> favorite >>>> $mId");
    userid = json['userid'];
    uid = mId;
    itemName = json['item_name'];
    locationId = json['location_id'];
    locationName = json['location_name'];
    boxId = json['box_id'];
    boxName = json['box_name'];
    image = json['image'];
    date = json['date '];
  }
  String? userid;
  String? uid;
  String? itemName;
  String? locationId;
  String? locationName;
  String? boxId;
  String? boxName;
  String? image;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userid'] = userid;
    map['uid'] = uid;
    map['item_name'] = itemName;
    map['location_id'] = locationId;
    map['location_name'] = locationName;
    map['box_id'] = boxId;
    map['box_name'] = boxName;
    map['image'] = image;
    map['date '] = date;
    return map;
  }
}
