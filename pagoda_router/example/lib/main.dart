import 'package:flutter/material.dart';
import 'package:pagoda_router/pagoda_router.dart';
import 'package:pagoda_router_example/detail_page.dart';
import 'package:pagoda_router_example/initial_page.dart';
import 'package:pagoda_router_example/user_page.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

  PagodaRouter pagodaRouter = PagodaRouter(
      registerRoutes: [
        PagodaRouteInfo(
          path: '/detail',
          name: 'detail',
          builder2: ({Map? args}) {
            return (context) => DetailPage(msg: args?['msg']);
          }

        ),

        PagodaRouteInfo(
          path: '/',
          name: 'root',
          builder: (context) => HomePage(onJumpToUser: (String str) {
            PagodaRouter.pagodaNavigator.navigateTo('detail', args: {'msg': '66666666'});
          }),
        ),
        PagodaRouteInfo(
          path: '/user',
          name: 'user',
          builder: (context) => UserPage(vid: '123123')
        ),
      ],

      // initialRoute: PagodaRouteInfo(
      //   path: '/initial',
      //   builder: (context) => InitialPage(),
      // )

    );

    return MaterialApp.router(
      routerDelegate: pagodaRouter.delegate, 
      routeInformationParser: pagodaRouter.routeInformationParser,
    );
  }
}
