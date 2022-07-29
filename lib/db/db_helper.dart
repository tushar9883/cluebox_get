import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/favorite_model.dart';
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
  static const String Favorite_Db = "FAVORITE";

  ///TODO Location Table
  DatabaseService<AddItemModel> additemdb = DatabaseService(Additem_DB,
      fromDS: (id, data) => AddItemModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  ///TODO Favorite Table
  DatabaseService<FavoriteModel> favoritedb = DatabaseService(Favorite_Db,
      fromDS: (id, data) => FavoriteModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  ///TODO Location Table Create
  DatabaseService<LocationModel> locationdb = DatabaseService(Location_Db,
      fromDS: (id, data) => LocationModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  ///TODO Box Table Create
  DatabaseService<BoxModel> boxdb = DatabaseService(BOX_Db,
      fromDS: (id, data) => BoxModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  ///TODO Tag Table Create
  DatabaseService<TagModel> tagdb = DatabaseService(TAG_Db,
      fromDS: (id, data) => TagModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  ///TODO User Table
  DatabaseService<UserModel> userdb = DatabaseService(User_DB,
      fromDS: (id, data) => UserModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  Future adduser(UserModel userModel) async {
    await userdb.create(userModel.toJson());
  }

  Future adlocation(LocationModel locationModel) async {
    return await locationdb.create(locationModel.toJson());
  }

  Future adfavorite(FavoriteModel favoriteModel) async {
    return await favoritedb.create(favoriteModel.toJson());
  }

  Future adbox(BoxModel boxModel) async {
    return await boxdb.create(boxModel.toJson());
  }

  Future addItem(AddItemModel addItemModel) async {
    await additemdb.create(addItemModel.toJson());
  }

  Future adtag(TagModel tagModel) async {
    await tagdb.create(tagModel.toJson());
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
      limit: 10,
    );
    return res;
  }

  Future<List<FavoriteModel>> getFavoriteList(String uids) async {
    List<FavoriteModel> res = await favoritedb.getQueryList(
      args: [
        QueryArgsV2(
          "userid",
          isEqualTo: uids,
        )
      ],
      // orderBy: [OrderBy("date", descending: true)],
      // limit: 10,
    );
    return res;
  }

  Future<List<LocationModel>> getAllLocation(String uids) async {
    List<LocationModel> res = await locationdb.getQueryList(
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

  Future<List<BoxModel>> getBoxLocationWise(String locID) async {
    List<BoxModel> res = await boxdb.getQueryList(
      args: [
        QueryArgsV2(
          "location_id",
          isEqualTo: locID,
        )
      ],
      orderBy: [OrderBy("date", descending: true)],
    );
    return res;
  }
}
