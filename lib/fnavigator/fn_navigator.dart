import 'package:flutter/material.dart';

import '../pages/demo_home_page.dart';
import '../pages/demo_target2_page.dart';
import '../pages/home_page.dart';
import '../pages/home_tab_page.dart';
import '../pages/login_page.dart';
import '../pages/registration_page.dart';
import 'bottom_navigator.dart';

// 1.定义路由参数 RouterDelegate的实现类中的泛型使用
class BiliRoutePath {}

MaterialPage pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

RouteStatus getStatus(MaterialPage page) {
  if (page.child is HomePage) {
    return RouteStatus.home;
  } else if (page.child is DemoTargetPage2) {
    return RouteStatus.target2;
  } else if (page.child is LoginPage) {
    return RouteStatus.login;
  } else if (page.child is RegistrationPage) {
    return RouteStatus.registration;
  } else {
    return RouteStatus.unknown;
  }
}

// 4.RouteStatus跟页面的关系映射
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

// 2.配置枚举
enum RouteStatus { login, registration, home, detail, unknown, target2 }

// 3.导航栏框架的 单例对象
class FnNavigator extends _RouteJumpListener {
  static FnNavigator? _instance;

  FnNavigator._();

  static FnNavigator getInstance() {
    if (_instance == null) {
      _instance = FnNavigator._();
    }
    return _instance!;
  }

  //页面栈
  List<MaterialPage> pageList = [];

  BiliRoutePath? path;

  RouteJumpListener? _routeJump;

  Map? args;

  //设置启动页面   默认设置为首页
  RouteStatus currentRouteStatus = RouteStatus.home;

  //3.3.注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

//管理栈区的逻辑
  managerStack() {
    print("导航框架 3 managerStack");
    //页面打开拦截
    //获取在栈区中的位置
    var index = _getPageIndex(pageList, routeStatus);
    List<MaterialPage> tempPages = pageList;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    var page = getPage(routeStatus);

    //已经处理的
    //打开
    tempPages = [...tempPages, page];
    // FwNavigator.getInstance().notify(tempPages, pages);
    //home --> login
    //原来的，当前页 home
    pageList = tempPages;
    print("导航框架 4 ${pageList}");
  }

  // routeStatus:用于做登录的拦截
  RouteStatus get routeStatus {
    print("导航框架 9 ${currentRouteStatus}");
    // if (_routeStatus != RouteStatus.registration && !hasLogin) {
    // if (currentRouteStatus != RouteStatus.registration) {
    //   print("导航框架 7 ${currentRouteStatus}");
    //   return currentRouteStatus = RouteStatus.login;
    // }
    //带入逻辑
    print("导航框架 8 ${currentRouteStatus}");
    return currentRouteStatus;
  }

  MaterialPage getPage(RouteStatus status) {
    var page;
    if (status == RouteStatus.home) {
      print("getpage....");
      pageList.clear();
      page = pageWrap(BottomNavigator());
    } else if (status == RouteStatus.target2) {
      page = pageWrap(DemoTargetPage2(
        args: args,
      ));
    }else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage());
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }
    print("导航框架 page ${page}");
    return page;
  }

  int _getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
    for (int i = 0; i < pages.length; i++) {
      MaterialPage page = pages[i];
      if (getStatus(page) == routeStatus) {
        return i;
      }
    }
    return -1;
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map<dynamic, dynamic>? args}) {
    _routeJump?.onJumpTo(routeStatus, args: args);
  }
}

//3.1.抽取出跳转的逻辑
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

//3.4.给方法取个别名
typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

//3.2.定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}
