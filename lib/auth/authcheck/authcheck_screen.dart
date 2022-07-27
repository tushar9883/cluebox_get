import 'dart:async';
import 'package:clue_get/base/base_view_view_model.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({Key? key}) : super(key: key);

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  FlutterSecureStorage storagess = const FlutterSecureStorage();
  String? isLoggedIn;

  @override
  void initState() {
    super.initState();
    getUid();
  }

  getUid() async {
    var check = await storagess.read(key: "uid");
    isLoggedIn = check;
    print(">>>>> User ID  ${check.toString()}  >>>>> ");

    Timer(
      const Duration(seconds: 3),
      () {
        if (isLoggedIn != null) {
          Get.offNamed(RouterName.home);
        } else {
          Get.offNamed(RouterName.login);
        }
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: REdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/image/splash.gif"),
        ),
      ),
    );
  }
}
