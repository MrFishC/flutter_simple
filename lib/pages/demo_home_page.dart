import 'package:flutter/material.dart';

import '../fnavigator/fn_navigator.dart';

class DemoHomePage extends StatefulWidget {
  DemoHomePage({Key? key}) : super(key: key);

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    // FwNavigator.getInstance().registerStatePage(widget, () {}, () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("主页"),
            MaterialButton(
              onPressed: () {
                Map args = {"data": "这个是数据..."};
                FnNavigator.getInstance()
                    .onJumpTo(RouteStatus.target2, args: args);
              },
              child: Text("跳转"),
            )
          ],
        ),
      ),
    );
  }

  //解决pageView机制加载问题
  @override
  bool get wantKeepAlive => true;
}
