import 'package:flutter/material.dart';
import 'package:hacthon2/screens/on_boarding.dart';

import 'network/cache_helper.dart';
import 'screens/home_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  late Widget widget ;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  if(onBoarding != null){
    widget = HomeScreen();
  }else{
    widget = OnBoardingScreen();
  }
  runApp( MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final  Widget? startWidget ;
  const MyApp({super.key,required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  OnBoardingScreen(),
    );
  }
}
