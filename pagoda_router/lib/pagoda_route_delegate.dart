part of pagoda_router;

class CurRoutePathInfo {
  final String path;
  final String name;
  CurRoutePathInfo({required this.path, required this.name});
}

class PagodaRouterDelegate extends RouterDelegate<PagodaRouteInfo> with ChangeNotifier, PopNavigatorRouterDelegateMixin<PagodaRouteInfo> {
  // 全局唯一的 key
  final GlobalKey<NavigatorState> navigatorKey;
  // 注册的所有页面
  final List<PagodaRouteInfo> registerRoutes;
  // 初始页面
  final PagodaRouteInfo? initialRoute;
  // 未找到路由的报错页面
  final ErrorPage errorPage;
  // 路由控制器
  final PagodaNavigator pagodaNavigator;
  // 路由栈
  List<Page<dynamic>> _stack = [];
  // 当前路由信息
  CurRoutePathInfo curRoutePathInfo = CurRoutePathInfo(path: '/', name: 'root');

  PagodaRouterDelegate({
    required this.errorPage,
    required this.initialRoute,
    required this.registerRoutes,
    required this.pagodaNavigator
  }): navigatorKey = GlobalKey<NavigatorState>() {
    pagodaNavigator.registerRouteNavigator(RouteNavigatorListener(navigateTo: (String routeName, {Map? args}) {
      print('registerRouteNavigator ------ > ${routeName} ----- ${args}');

      curRoutePathInfo = CurRoutePathInfo(path: '/detail', name: 'detail');

      notifyListeners();
    }));
  }

  @override
  Widget build(BuildContext context) {
    print('PagodaRouterDelegate build ----- ${curRoutePathInfo.name}');

    // 获取当前页面在路由栈中的位置
    int index = pagodaNavigator.getPageIndex(_stack, curRoutePathInfo);
    // 临时栈
    List<Page<dynamic>> _tempStack = _stack;
    // 如果存在的话，则将该页面和它上面的所有页面出栈
    if (index != -1) {
      _tempStack = _tempStack.sublist(0, index);
    }

    // 当前页面的 Page
    Page<dynamic> curPage;

    // 根路由
    if (curRoutePathInfo.path == '/') {
      _stack.clear();
      // 未设置初始页面，且路径为 / 的，跳转至注册路由中的 / 页面
      // 设置初始页面的时候则取初始页面
      var _rootPageInfo = initialRoute ?? registerRoutes.where((route) => route.path == '/').toList()[0];

      curPage = PagodaPage(key: ValueKey(_rootPageInfo.path), name: _rootPageInfo.name, builder: _rootPageInfo.builder!);

    } else if (curRoutePathInfo.path == '/404') {

      print('curRoutePath == /404');
      curPage = PagodaPage(key: const ValueKey('/404'), name: '404', builder: (context) => errorPage);

    } else {
      var _curPageInfo = registerRoutes.where((route) => route.path == curRoutePathInfo.path).toList()[0];
      print('-------------------');

      // curPage = PagodaPage(key: ValueKey(_curPageInfo.path), name: _curPageInfo.name, builder: _curPageInfo.builder!);

      curPage = PagodaPage(key: ValueKey(_curPageInfo.path), name: _curPageInfo.name, builder: _curPageInfo.builder2!(args: {'msg': '2222'}));
    }
    

    _tempStack = [..._tempStack, curPage];

    _stack = _tempStack;


    return WillPopScope(
      onWillPop: () async => !(await navigatorKey.currentState?.maybePop() ?? false),
      child: Navigator(
        key: navigatorKey,
        pages: _stack,
        onPopPage: (route, result) {
          print(route);
          return route.didPop(result);
        },
      )
    );
  }

  @override
  Future<void> setInitialRoutePath(PagodaRouteInfo configuration) async {
    setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(PagodaRouteInfo configuration) async {
    print('setNewRoutePath --------> ${configuration.path}');
    curRoutePathInfo = CurRoutePathInfo(path: configuration.path, name: configuration.name);
  }

}