library pagoda_router;

// import 'dart:js';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'pagoda_route_info.dart';
part 'pagoda_navigator.dart';
part 'pagoda_route_page.dart';
part 'pagoda_route_delegate.dart';
part 'pagoda_route_information_parser.dart';

part 'common/error_page.dart';

class PagodaRouter {
  // 初始路由信息
  final PagodaRouteInfo? initialRoute;
  // 报错的路由页面显示
  final ErrorPage? errorRoutePage;
  // 注册路由数据
  final List<PagodaRouteInfo> registerRoutes;


  static final pagodaNavigator = PagodaNavigator.getInstance();

  // 路由导航控制器
  // PagodaNavigator _pagodaNavigator = PagodaNavigator.getInstance();

  late PagodaRouterDelegate _delegate;
  late PagodaRouteInformationParser _routeInformationParser;

  PagodaRouter({
    required this.registerRoutes,
    this.initialRoute,
    this.errorRoutePage
  }) {

    _delegate = PagodaRouterDelegate(
      initialRoute: initialRoute,
      registerRoutes: registerRoutes,
      errorPage: errorRoutePage ?? const ErrorPage(),
      
      pagodaNavigator: pagodaNavigator
    );

    _routeInformationParser = PagodaRouteInformationParser(
      registerRoutes: registerRoutes
    );
  }

  // 路由代理
  PagodaRouterDelegate get delegate {
    return _delegate;
  }

  // 路由解析
  PagodaRouteInformationParser get routeInformationParser {
    return _routeInformationParser;
  }


  
}