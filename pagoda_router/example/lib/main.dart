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
        PagodaRoute(
          path: '/',
          name: 'home',
          builder: ({Map? params}) {
            return (context) => HomePage();
          }
        ),
        PagodaRoute(
          path: '/detail',
          name: 'detail',
          builder: ({Map? params}) {
            return (context) => DetailPage(msg: params?['msg']);
          }
        ),
        PagodaRoute(
          path: '/user',
          name: 'user',
          builder: ({Map? params}) {
            return (context) => UserPage(vid: params?['vid']);
          }
        ),
      ]
    );

    return MaterialApp.router(
      routerDelegate: pagodaRouter.delegate, 
      routeInformationParser: pagodaRouter.routeInformationParser,
    );
  }
}
