part of pagoda_router;

class PagodaNavigator extends _RouteNavigatorListener {
  static PagodaNavigator? _instance;

  PagodaNavigator._();

  static PagodaNavigator getInstance() {
    _instance ??= PagodaNavigator._();
    return _instance!;
  }

  RouteNavigatorListener? _routeNavigator;

  // 注册路由的跳转逻辑
  void registerRouteNavigator(RouteNavigatorListener routeNavigatorListener) {
    _routeNavigator = routeNavigatorListener;
  }

  // 跳转逻辑
  @override
  void navigateTo(String routeName, {Map? args}) {
    _routeNavigator?.navigateTo(routeName, args: args);
  }


  // 获取当前要打开的页面在路由堆栈中的位置
  int getPageIndex (List<Page<dynamic>> stack, CurRoutePathInfo curRoutPathInfo) {
    for (int i = 0; i < stack.length; i++) {
      var page = stack[i];
      if (page.name == curRoutPathInfo.name) {
        return i;
      }
    }
    return -1;
  }
}

// 抽象类供 PagodaNavigator 实现
abstract class _RouteNavigatorListener {
  void navigateTo(String routeName, {Map? args});
}

typedef NavigateTo = void Function(String routeName, {Map? args});

// 定义路由跳转逻辑要实现的功能
class RouteNavigatorListener {
  final NavigateTo navigateTo;

  RouteNavigatorListener({required this.navigateTo});
}
