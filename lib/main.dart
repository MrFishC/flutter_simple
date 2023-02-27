import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_simple/widget/index.dart';
import 'package:path_provider/path_provider.dart';

import 'fhttp/fn_error.dart';
import 'fhttp/fn_net.dart';
import 'fhttp/test_request.dart';
import 'fnavigator/fn_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FBiliBili App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BibiPage(),
    );
  }
}

class BibiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BibiPageState();
  }
}

class _BibiPageState extends State<BibiPage> {
  BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return Router(routerDelegate: _routeDelegate);
  }
}

// 自行管理页面栈
class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRoutePath> {
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    // 注册回调
    FnNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      print("导航框架 2 registerRouteJump");
      FnNavigator.getInstance().currentRouteStatus = routeStatus;
      FnNavigator.getInstance().args = args;
      notifyListeners();
    }));

    //   其它业务  如：设置拦截器
  }

  @override
  Widget build(BuildContext context) {
    FnNavigator.getInstance().managerStack();

    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: FnNavigator.getInstance().pageList,
          onPopPage: (route, result) {
            print("导航路由框架 ${route}");
            if (!route.didPop(result)) {
              return false;
            }
            //关闭页面通知路由变化
            FnNavigator.getInstance().pageList.removeLast();
            return true;
          },
        ),
        onWillPop: () async =>
            !(await navigatorKey?.currentState?.maybePop() ?? false));
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {
    FnNavigator.getInstance().path = configuration;
  }

  @override
  GlobalKey<NavigatorState>? navigatorKey; //问题，为什么这里重命名就会报错
}
