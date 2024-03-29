import 'package:f_util_go/util/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../theme/theme_provider.dart';

///顶部tab切换组件
class FwTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;

  const FwTab(this.tabs,
      {Key? key,
      this.controller,
      this.fontSize = 13,
      this.borderWidth = 2,
      this.insets = 15,
      this.unselectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    var _unselectedLabelColor =
    themeProvider.isDark() ? Colors.white70 : unselectedLabelColor;
    return TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: primary,
        unselectedLabelColor: _unselectedLabelColor,
        // unselectedLabelColor: unselectedLabelColor,
        labelStyle: TextStyle(fontSize: fontSize),
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.square,
            borderSide: BorderSide(color: primary, width: borderWidth),
            insets: EdgeInsets.only(left: insets, right: insets)),
        tabs: tabs);
  }
}
