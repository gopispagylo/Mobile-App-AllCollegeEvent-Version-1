import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/data/controller/DeepLinkService/DeepLinkService.dart';
import 'package:all_college_event_app/features/auth/chechUser/ui/CheckUserPage.dart';
import 'package:all_college_event_app/features/auth/splashScreen/model/SplashScreenModel.dart';
import 'package:all_college_event_app/features/tabs/bottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:all_college_event_app/utlis/globalUnFocus/GlobalUnFocus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toastification/toastification.dart';


// --------- GlobalKey for outside navigator access its called global context ---------
final navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // DotEnv file initialized
  await dotenv.load(fileName: '.env');

  // Set initial base url
  await ApiController().setBaseUrl();

  // -------- Access the db --------
  var data = await DBHelper().getIsSplash();
  var loginData = await DBHelper().getIsLogin();

  bool isSplash = data.isNotEmpty;
  bool isLogin = loginData.isNotEmpty;

  // --------- initial deeplink ------
  DeepLinkService().initial;

  // Device only portrait view
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp(isSplash: isSplash, isLogin: isLogin,));
  });
}

class MyApp extends StatefulWidget {
  final bool isSplash;
  final bool isLogin;

  const MyApp({super.key, required this.isSplash, required this.isLogin});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  // ------- find user assign the value ------
  String? checkUser;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  // ------- find a user --------
  Future<void> getUser() async {
    String? user = await DBHelper().getUser();
    setState(() {
      checkUser = user;
    });
  }

  // ----- global unfocused the keyboard -----
  @override
  void dispose() {
    GlobalUnFocus.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              scrolledUnderElevation: 0.0,
            )
          ),
          home: widget.isSplash
              ? widget.isLogin ? checkUser == null ? Center(child: CircularProgressIndicator(color: MyColor().primaryClr,),) : BottomNavigationBarPage(pageIndex: 0, whichScreen: checkUser!,) : CheckUserPage()
              : OnboardingScreenModel()
          // home: BottomNavigationBarPage(pageIndex: 0),
        ),
      ),
    );
  }
}




