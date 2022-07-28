import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

class DbHelp {
  static const String User_DB = "USER";
  static const String Additem_DB = "ADDITEM";
  static const String Location_Db = "LOCATION";
  static const String BOX_Db = "BOX";
  static const String TAG_Db = "TAG";

  ///TODO Location Table
  DatabaseService<AddItemModel> additemdb = DatabaseService(Additem_DB,
      fromDS: (id, data) => AddItemModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  Future addlocation(AddItemModel addItemModel) async {
    await additemdb.create(addItemModel.toJson());
  }

  Future<List<AddItemModel>> getAllItemList(String uids) async {
    List<AddItemModel> res = await additemdb.getQueryList(
      args: [
        QueryArgsV2(
          "userid",
          isEqualTo: uids,
        )
      ],
      orderBy: [OrderBy("date", descending: true)],
    );
    return res;
  }

  ///TODO Location Table Create
  DatabaseService<LocationModel> locationdb = DatabaseService(Location_Db,
      fromDS: (id, data) => LocationModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  Future adlocation(LocationModel locationModel) async {
    await locationdb.create(locationModel.toJson());
  }

  ///TODO Box Table Create
  DatabaseService<BoxModel> boxdb = DatabaseService(BOX_Db,
      fromDS: (id, data) => BoxModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  Future adbox(BoxModel boxModel) async {
    await boxdb.create(boxModel.toJson());
  }

  ///TODO Tag Table Create
  DatabaseService<TagModel> tagdb = DatabaseService(TAG_Db,
      fromDS: (id, data) => TagModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  Future adtag(TagModel tagModel) async {
    await tagdb.create(tagModel.toJson());
  }

  ///TODO User Table
  DatabaseService<UserModel> userdb = DatabaseService(User_DB,
      fromDS: (id, data) => UserModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  Future adduser(UserModel userModel) async {
    await userdb.create(userModel.toJson());
  }
}
