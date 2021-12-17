part of pagoda_router;

class PagodaRouterDelegate extends RouterDelegate<PagodaRouteParserInfo> with ChangeNotifier, PopNavigatorRouterDelegateMixin<PagodaRouteParserInfo> {
  // 全局唯一的 key
  final GlobalKey<NavigatorState> navigatorKey;
  // 注册的所有页面
  final List<PagodaRoute> registerRoutes;
  // 初始页面
  final PagodaRoute? initialRoute;
  // 未找到路由的报错页面
  final ErrorPage errorPage;
  // 路由控制器
  final PagodaNavigator pagodaNavigator;
  // 路由栈
  List<Page<dynamic>> _stack = [];

  // 当前路由信息
  PagodaRouteParserInfo curRouteInfo = PagodaRouteParserInfo(path: '/', name: 'home');

  PagodaRouterDelegate({
    required this.errorPage,
    required this.initialRoute,
    required this.registerRoutes,
    required this.pagodaNavigator
  }): navigatorKey = GlobalKey<NavigatorState>() {
    pagodaNavigator.registerRouteNavigator(RouteNavigatorListener(navigateTo: (String routeName, {Map? params}) {
      print('registerRouteNavigator ------ > ${routeName} ----- ${params}');

      curRouteInfo = PagodaRouteParserInfo(path: '/${routeName}', name: routeName, params: params);

      notifyListeners();
    }));
  }

  @override
  Widget build(BuildContext context) {
    print('PagodaRouterDelegate build curRouteInfo ----- ${curRouteInfo.name}');

    // 获取当前页面在路由栈中的位置
    int index = pagodaNavigator.getPageIndex(_stack, curRouteInfo);

    // 临时栈
    List<Page<dynamic>> _tempStack = _stack;

    // 如果存在的话，则将该页面上面的所有页面出栈
    if (index != -1) {
      _tempStack = _tempStack.sublist(0, index);
    }

    // 当前页面的 Page
    Page<dynamic> curPage;

    // 根路由
    if (curRouteInfo.path == '/' && curRouteInfo.name == 'home') {
      _stack.clear();

      PagodaRoute homeRoutInfo;
      
      if (initialRoute != null) {
        homeRoutInfo = initialRoute!;
      } else {
        homeRoutInfo = registerRoutes.where((route) => route.path == '/' && route.name == 'home').toList()[0];
      }
      curPage = PagodaPage(key: ValueKey(homeRoutInfo.name), name: homeRoutInfo.name, builder: homeRoutInfo.builder!());

    } else {
      var pageRouteInfo = registerRoutes.where((route) => route.name == curRouteInfo.name).toList();
      
      if (pageRouteInfo.isNotEmpty) {
        curPage = PagodaPage(key: ValueKey(pageRouteInfo[0].name), name: pageRouteInfo[0].name, builder: pageRouteInfo[0].builder!(params: curRouteInfo.params));
      } else {
        curPage = PagodaPage(key: ValueKey('404'), name: '404', builder: (context) => errorPage);
      }
    }

    _tempStack = [..._tempStack, curPage];

    print('_tempStack  ${_tempStack}  _stack  ${_stack}');

    pagodaNavigator.notifyRouteChange(_tempStack, _stack);

    _stack = _tempStack;

    return WillPopScope(
      onWillPop: () async => !(await navigatorKey.currentState?.maybePop() ?? false),
      child: Navigator(
        key: navigatorKey,
        pages: _stack,
        onPopPage: (route, result) {
          print('onPopPage ${route} ${result}');
          if (!route.didPop(result)) {
            return false;
          }
          var _tempStack = [..._stack];
          _stack.removeLast();
          pagodaNavigator.notifyRouteChange(_tempStack, _stack);
          return true;
        },
      )
    );
  }

  @override
  Future<void> setInitialRoutePath(PagodaRouteParserInfo configuration) async {
    setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(PagodaRouteParserInfo configuration) async {
    print('setNewRoutePath --------> ${configuration.path} ${configuration.name} ${configuration.params} ${configuration.state}');
    curRouteInfo = configuration;
  }

}