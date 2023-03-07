import 'package:f_net_go/cache/fc_cache.dart';
import 'package:f_util_go/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../util/constants.dart';

//extension 可以在不更改类或创建子类的情况下，向类添加扩展功能的一种方式。灵活使用 extension 对基础类进行扩展，对开发效率有显著提升。
extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

//1.定义provider使用的数据模型
class ThemeProvider extends ChangeNotifier{
  ThemeMode? _themeMode;

  //平台模式状态
  var _platformBrightness = SchedulerBinding.instance.window.platformBrightness;

  ///系统Dark Mode发生变化
  void darModeChange() {
    print("系统Dark Mode发生变化.......${_platformBrightness !=
        SchedulerBinding.instance.window.platformBrightness}");
    //是否发生变化
    if (_platformBrightness !=
        SchedulerBinding.instance.window.platformBrightness) {
      //变更状态
      _platformBrightness = SchedulerBinding.instance.window.platformBrightness;
      //更新  改变provider的数据
      notifyListeners();
    }
  }

  ///获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        errorColor: isDarkMode ? FwColor.dark_red : FwColor.red,
        primaryColor: isDarkMode ? FwColor.dark_bg : white,
        //Tab指示器的颜色
        indicatorColor: isDarkMode ? primary[50] : white,
        //页面背景色
        scaffoldBackgroundColor: isDarkMode ? FwColor.dark_bg : white);
    return themeData;
  }

  ///获取主题模式
  ThemeMode getThemeMode() {
    String? theme = FcCache.getInstance().get(Constants.theme);
    switch (theme) {
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'System':
        _themeMode = ThemeMode.system;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode!;
  }

  ///设置主题
  void setTheme(ThemeMode themeMode) {
    print("参数数据${themeMode.value}");
    FcCache.getInstance().setString(Constants.theme, themeMode.value);
    notifyListeners();
  }

  ///判断是否是Dark Mode
  bool isDark() {
    // if (_themeMode == ThemeMode.system) {
    //   //获取系统的Dark Mode
    //   return SchedulerBinding.instance.window.platformBrightness ==
    //       Brightness.dark;
    // }
    return _themeMode == ThemeMode.dark;
  }
}
