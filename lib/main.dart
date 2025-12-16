import 'package:all_college_event_app/data/controller/ApiController/ApiController.dart';
import 'package:all_college_event_app/data/controller/DBHelper/DBHelper.dart';
import 'package:all_college_event_app/features/auth/chechUser/ui/CheckUserPage.dart';
import 'package:all_college_event_app/features/auth/journey/ui/JourneyPage.dart';
import 'package:all_college_event_app/features/auth/splashScreen/ui/SplashScreenPage.dart';
import 'package:all_college_event_app/features/tabs/bottomNavigationBar/BottomNavigationBarPage.dart';
import 'package:all_college_event_app/utlis/color/MyColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  print("datadatadatadatadatadatadatadatadata$data");

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


  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(0.85)),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            scrolledUnderElevation: 0.0,
          )
        ),
        home: widget.isSplash
            ? widget.isLogin ? BottomNavigationBarPage(pageIndex: 0) : CheckUserPage()
            : SplashScreenPage()
        // home: BottomNavigationBarPage(pageIndex: 0),
      ),
    );
  }
}




