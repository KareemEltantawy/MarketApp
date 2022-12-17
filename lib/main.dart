import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/bloc_observer.dart';
import 'package:shopping_app/shared/components/constants.dart';
import 'package:shopping_app/shared/cubit/cubit.dart';
import 'package:shopping_app/shared/cubit/states.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';
import 'package:shopping_app/shared/network/remote/dio_helper.dart';
import 'package:shopping_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/shop_layout.dart';
import 'modules/login/shop_login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

import 'dart:io';//to solve error when run on  my phone
class MyHttpOverrides extends HttpOverrides{ //to solve error when run on  my phone
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();//to solve error when run on  my phone
  await CacheHelper.init();  //lAn ba await ala CacheHelper.init() lazem el main ybka async we lAn el main bka async lazwm adef el method...> WidgetsFlutterBinding.ensureInitialized()

  DioHelper.init();

  Bloc.observer = MyBlocObserver();

  bool? isDark = CacheHelper.getData(key: 'isDark'); // we use the same key we use in saveData method

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token'); // we define token in constants file as we will use it in other files

  Widget startWidget;

  if(onBoarding != null) {
    if(token != null)
    {
      startWidget = ShopLayout();
    } else
      {
        startWidget = ShopLoginScreen();
      }
  } else
    {
      startWidget = OnBoardingScreen();
    }

  runApp(MyApp(isDark: isDark, startWidget: startWidget));
}


class MyApp extends StatelessWidget
{
  bool? isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..changeAppMode(isDarkFromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
