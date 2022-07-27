import 'package:clue_get/model/location_model.dart';
import 'package:clue_get/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

class DbHelp {
  static const String User_DB = "User";
  static const String Location_DB = "Location";

  ///TODO Location Table
  DatabaseService<LocationModel> locationdb = DatabaseService(Location_DB,
      fromDS: (id, data) => LocationModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  Future addlocation(LocationModel location_details) async {
    await locationdb.create(location_details.toJson());
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

  ///TODO User Table

  DatabaseService<UserModel> userdb = DatabaseService(User_DB,
      fromDS: (id, data) => UserModel.fromJson(id, data),
      toMap: (data) => data.toJson());

  Future adduser(UserModel userModel) async {
    await userdb.create(userModel.toJson());
  }

  ///TODO User Table Get Details
  Future<List<UserModel>> getSpecificUser() async {
    List<UserModel> res = await userdb.getQueryList(args: [
      QueryArgsV2("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
    ]);
    return res;
  }
}
