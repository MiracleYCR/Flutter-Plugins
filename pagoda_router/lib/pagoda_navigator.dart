part of pagoda_router;

typedef PagodaRouteChangeListener(String cur, String prev);

class PagodaNavigator extends _RouteNavigatorListener {
  static PagodaNavigator? _instance;

  PagodaNavigator._();

  static PagodaNavigator getInstance() {
    _instance ??= PagodaNavigator._();
    return _instance!;
  }

  RouteNavigatorListener? _routeNavigator;
  List<PagodaRouteChangeListener> _listeners = [];

  // 打开新页面前当前的页面
  var _currentPage;

  // 注册路由的跳转逻辑
  void registerRouteNavigator(RouteNavigatorListener routeNavigatorListener) {
    _routeNavigator = routeNavigatorListener;
  }

  // 监听路由页面的跳转
  void addListener (PagodaRouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  // 移除监听
  void removeListener (PagodaRouteChangeListener listener) {
    _listeners.remove(listener);
  }

  // 通知路由页面变化
  void notifyRouteChange(List<Page<dynamic>> currentStack, List<Page<dynamic>> prevStack) {
    print('----------------- notifyRouteChange ---------------:  ${currentStack}  ${prevStack}');
    if (currentStack == prevStack) return;
    var current = currentStack.last;
    print(current);
    _notifyRouteChange(current);
  }

  void _notifyRouteChange (Page<dynamic> current) {
    print('pagoda_navigator：current: ${current.name}');
    // print('pagoda_navigator：prev: ${_currentPage.name!}');
    _listeners.forEach((listener) {
      listener(current.name!, 'home');
      _currentPage = current;
    });
  }

  // 跳转逻辑
  @override
  void navigateTo(String routeName, {Map? params}) {
    _routeNavigator?.navigateTo(routeName, params: params);
  }

  // 获取当前要打开的页面在路由堆栈中的位置
  int getPageIndex (List<Page<dynamic>> stack, PagodaRouteParserInfo cuRouteInfo) {
    for (int i = 0; i < stack.length; i++) {
      var page = stack[i];
      if (page.name == cuRouteInfo.name) {
        return i;
      }
    }
    return -1;
  }
}

// 抽象类供 PagodaNavigator 实现
abstract class _RouteNavigatorListener {
  void navigateTo(String routeName, {Map? params});
}

typedef NavigateTo = void Function(String routeName, {Map? params});

// 定义路由跳转逻辑要实现的功能
class RouteNavigatorListener {
  final NavigateTo navigateTo;

  RouteNavigatorListener({required this.navigateTo});
}
