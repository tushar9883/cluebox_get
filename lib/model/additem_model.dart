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
    this.box,
    this.location,
    this.quantity,
    this.date,
    this.image,
  });

  AddItemModel.fromJson(String mId, dynamic json) {
    print(">>>>> AddItem >>>> $mId");
    uid = mId;
    userid = json['userid'];
    itemName = json['item_name'];
    tag = json['tag'];
    box = json['box'];
    location = json['location'];
    quantity = json['quantity'];
    date = json['date'];
    image = json['image'];
  }
  String? uid;
  String? userid;
  String? itemName;
  String? tag;
  String? box;
  String? location;
  String? quantity;
  String? date;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    map['userid'] = userid;
    map['item_name'] = itemName;
    map['tag'] = tag;
    map['box'] = box;
    map['location'] = location;
    map['quantity'] = quantity;
    map['date'] = date;
    map['image'] = image;
    return map;
  }
}
