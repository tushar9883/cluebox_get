import 'package:clue_get/auth/authcheck/authcheck_screen.dart';
import 'package:clue_get/auth/forgot/forgot_binding.dart';
import 'package:clue_get/auth/forgot/forgot_screen.dart';
import 'package:clue_get/auth/login/login_binding.dart';
import 'package:clue_get/auth/login/login_screen.dart';
import 'package:clue_get/auth/singup/singup_binding.dart';
import 'package:clue_get/auth/singup/singup_screen.dart';
import 'package:clue_get/router/router_name.dart';
import 'package:clue_get/screeen/boxes/my_boxes.dart';
import 'package:clue_get/screeen/boxes/my_boxes_binding.dart';
import 'package:clue_get/screeen/home/home_binding.dart';
import 'package:clue_get/screeen/home/home_screen.dart';
import 'package:clue_get/screeen/item/additem/additem_binding.dart';
import 'package:clue_get/screeen/item/additem/additem_screen.dart';
import 'package:clue_get/screeen/item/allitem/allitem_binding.dart';
import 'package:clue_get/screeen/item/allitem/allitem_screen.dart';
import 'package:clue_get/screeen/item/edititem/edititem_screen.dart';
import 'package:clue_get/screeen/item/favoriteitem/favorite_binding.dart';
import 'package:clue_get/screeen/item/favoriteitem/favoriteitem_screen.dart';
import 'package:clue_get/screeen/locations/my_locations.dart';
import 'package:clue_get/screeen/locations/my_locations_binding.dart';
import 'package:clue_get/screeen/search/search_binding.dart';
import 'package:clue_get/screeen/search/search_screen.dart';
import 'package:clue_get/screeen/setting/changemail/changemail_binding.dart';
import 'package:clue_get/screeen/setting/changemail/changemail_screen.dart';
import 'package:clue_get/screeen/setting/changepass/changepass_binding.dart';
import 'package:clue_get/screeen/setting/changepass/changepass_screen.dart';
import 'package:clue_get/screeen/setting/personal/personal_binding.dart';
import 'package:clue_get/screeen/setting/personal/personal_screen.dart';
import 'package:clue_get/screeen/setting/settingpage/setting_binding.dart';
import 'package:clue_get/screeen/setting/settingpage/setting_screen.dart';
import 'package:clue_get/screeen/tag/tag/tag_binding.dart';
import 'package:clue_get/screeen/tag/tag/tag_screen.dart';
import 'package:clue_get/screeen/tag/tagitem/tagitem_binding.dart';
import 'package:clue_get/screeen/tag/tagitem/tagitem_screen.dart';
import 'package:clue_get/screeen/view/view_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../screeen/item/edititem/edititem_binding.dart';
import '../screeen/view/view_binding.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
          name: RouterName.home,
          page: () => const HomeScreen(),
          binding: HomeBinding()),
      GetPage(
          name: RouterName.login,
          page: () => const LoginScreen(),
          binding: LoginBinding()),
      GetPage(
          name: RouterName.forgotpassword,
          page: () => const ForgotScreen(),
          binding: ForgotBinding()),
      GetPage(
          name: RouterName.signup,
          page: () => const SingupScreen(),
          binding: SingupBinding()),
      GetPage(
          name: RouterName.additem,
          page: () => const AdditemScreen(),
          binding: AddItemBinding()),
      GetPage(
          name: RouterName.allitem,
          page: () => const AllItemScreen(),
          binding: AllItemBinding()),
      GetPage(
          name: RouterName.edititem,
          page: () => const EditItemScreen(),
          binding: EditItemBinding()),
      GetPage(
          name: RouterName.favorite,
          page: () => const FavoriteScreen(),
          binding: FavoriteBinding()),
      GetPage(
          name: RouterName.search,
          page: () => const SearchScreen(),
          binding: SearchBinding()),
      GetPage(
          name: RouterName.setting,
          page: () => const SettingScreen(),
          binding: SettingBinding()),
      GetPage(
          name: RouterName.changemail,
          page: () => const ChangeMailScreen(),
          binding: ChangeMailBinding()),
      GetPage(
          name: RouterName.changepass,
          page: () => const ChangePassScreen(),
          binding: ChangePassBinding()),
      GetPage(
          name: RouterName.personal,
          page: () => const PersonalScreen(),
          binding: PersonalBinding()),
      GetPage(
          name: RouterName.tag,
          page: () => const TagScreen(),
          binding: TagBinding()),
      GetPage(
          name: RouterName.tagitem,
          page: () => const TagItemScreen(),
          binding: TagItemBinding()),
      GetPage(
        name: RouterName.authcheck,
        page: () => const AuthCheckScreen(),
      ),
      GetPage(
          name: RouterName.myLocation,
          page: () => const MyLocation(),
          binding: MyLocationBinding()),
      GetPage(
          name: RouterName.myBoxes,
          page: () => const MyBoxes(),
          binding: MyBoxBinding()),
      GetPage(
          name: RouterName.viewpage,
          page: () => const ViewScreen(),
          binding: ViewBinding()),

      // GetPage(
      //     name: RouterName.search,
      //     page: () => const SearchPage(),
      //     binding: SearchBinding()),
    ];
  }
}
