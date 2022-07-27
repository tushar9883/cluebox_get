import 'package:clue_get/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';

class DbHelp {
  static const String User_DB = "User";

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
