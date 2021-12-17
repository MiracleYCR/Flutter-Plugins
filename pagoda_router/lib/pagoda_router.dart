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
  final PagodaRoute? initialRoute;
  
  // 注册路由数据
  final List<PagodaRoute> registerRoutes;

  // 报错的路由页面显示
  final ErrorPage? errorRoutePage;
  
  // 路由导航器
  static final pagodaNavigator = PagodaNavigator.getInstance();

  // 路由代理器
  late PagodaRouterDelegate _delegate;

  // 路由解析器
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

    _routeInformationParser = PagodaRouteInformationParser();
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