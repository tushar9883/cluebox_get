/// uid : ""
/// userid : ""
/// item_name : "pendrive"
/// tag : "pendrive"
/// box : "cabot"
/// location : "home"
/// quantity : "1"
/// date : ""
/// image : ""

class AddItemModel {
  AddItemModel({
    this.uid,
    this.userid,
    this.itemName,
    this.tag,
    this.boxName,
    this.locationName,
    this.quantity,
    this.date,
    this.image,
    this.boxId,
    this.locationId,
  });

  AddItemModel.fromJson(String mId, dynamic json) {
    print(">>>>> AddItem >>>> $mId");
    uid = mId;
    userid = json['userid'];
    itemName = json['item_name'];
    tag = json['tag'];
    boxName = json['box'];
    locationName = json['location'];
    quantity = json['quantity'];
    date = json['date'];
    image = json['image'];
    boxId = json['boxId'];
    locationId = json['location_id'];
  }
  String? uid;
  String? userid;
  String? itemName;
  List? tag;
  String? boxName;
  String? locationName;
  String? quantity;
  String? date;
  String? image;
  String? boxId;
  String? locationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['userid'] = userid;
    map['item_name'] = itemName;
    map['tag'] = tag;
    map['box'] = boxName;
    map['location'] = locationName;
    map['quantity'] = quantity;
    map['date'] = date;
    map['image'] = image;
    map['boxId'] = boxId;
    map['location_id'] = locationId;
    return map;
  }
}
