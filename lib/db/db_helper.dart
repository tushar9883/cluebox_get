import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clue_get/model/additem_model.dart';
import 'package:clue_get/model/box_model.dart';
import 'package:clue_get/model/location_model.dart';
import 'package:clue_get/model/tag_model.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

class DbHelp {
  static const String User_DB = "USER";
  static const String Additem_DB = "ITEM";
  static const String Location_Db = "LOCATION";
  static const String BOX_Db = "BOX";
  static const String TAG_Db = "TAG";
  static const String Favorite_Db = "FAVORITE";
  static const String PersonalInfo_Db = "PERSONALINFO";

  final db = FirebaseFirestore.instance;

  ///TODO Location Table
  DatabaseService<AddItemModel> additemdb = DatabaseService(Additem_DB,
      fromDS: (id, data) => AddItemModel.fromJson(id, data),
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
    return await userdb.create(userModel.toJson());
  }

  Future adlocation(LocationModel locationModel) async {
    return await locationdb.create(locationModel.toJson());
  }

  Future adbox(BoxModel boxModel) async {
    return await boxdb.create(boxModel.toJson());
  }

  Future addItem(AddItemModel addItemModel) async {
    await additemdb.create(addItemModel.toJson());
  }

  Future addtag(TagModel tagModel) async {
    return tagdb.create(tagModel.toJson(), id: tagModel.uid);
  }

  Future<List<AddItemModel>> getRecentItemList(String uids) async {
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

  Future<List<AddItemModel>> getAllFavoriteList(String uids) async {
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

  Future<List<TagModel>> getAllitms() async {
    List<TagModel> res = await tagdb.getQueryList(
      args: [
        QueryArgsV2(
          "tag",
          arrayContains: "HFk877BKTofgtWNalPpG",
        )
      ],
    );

    return res;
  }

  Future<TagModel?> getTagData(String id) async {
    TagModel? res = await tagdb.getSingle(id);
    return res;
  }

  Future<List<UserModel>> getUserDetails(String user) async {
    List<UserModel> res = await userdb.getQueryList(
      args: [
        QueryArgsV2(
          "userid",
          isEqualTo: user,
        )
      ],
    );
    return res;
  }

  Future updateFavorite(AddItemModel addItemModel, String? id) async {
    print(">>>>>>> loc id $id");
    await additemdb.updateData(
      id ?? "",
      {"favorite": addItemModel.favorite ?? false},
      // {"favorite": addItemModel.favorite ?? false}, only single data update krva mate
    );
  }

  Future updateUser(UserModel userModel, String? id) async {
    print(">>>>>>> update id $id");
    await userdb.updateData(
      id ?? "",
      {
        "uid": id,
        "name": userModel.name,
        "country": userModel.country,
        "gender": userModel.gender,
        "birthdate": userModel.birthdate,
      },
    );
  }

  Future udpateUserData(UserModel userModel, String? id) async {
    print(">>>>>>> loc id $id");
    await userdb.updateData(
      id ?? "",
      {"item_Count": userModel.itemCount},
    );
  }

  Future getAllTagsByUser(String userId) async {
    try {
      List<TagModel> res = await tagdb.getQueryList(
        args: [
          QueryArgsV2(
            "userid",
            isEqualTo: userId,
          )
        ],
        orderBy: [OrderBy("date", descending: true)],
      );
      print('OOOOOOOOOOOOOOOOOOOOOOOO');
      return res;
    } catch (e, s) {
      print("EEEEEEEEEEEEEEEE${e}");
      print('SSSSSSSSSSSSSSSSSSSS${s}');
    }
  }

  Future<List<UserModel>> getuserData(String uids) async {
    List<UserModel> res = await userdb.getQueryList(
      args: [
        QueryArgsV2(
          "userid",
          isEqualTo: uids,
        )
      ],
      limit: 1,
      //orderBy: [OrderBy("date", descending: true)],
    );
    return res;
  }

  Future<List<AddItemModel>> getItemsFromTag(String tagId) async {
    List<AddItemModel> res = await additemdb.getQueryList(
      args: [
        QueryArgsV2(
          "tag",
          arrayContains: tagId,
        )
      ],
      orderBy: [OrderBy("date", descending: true)],
    );
    return res;
  }
}
