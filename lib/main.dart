import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: ImageAndIconRoute(),
      // home: IconWidget(),
      // home: InputWidget(),
      // home: BoxLayout(),
      // home: RowLayout(),
      // home: ColumnLayout(),
      // home: ColumnLayout2(),
      // home: FlexLayout(),
      // home: WrapLayout(),
      // home: StackLayout(),
      // home: StackLayout1(),
      // home: StackLayout2(),
      // home: LayoutBuilderRoute(),  //效果没有达到
      // home: AfterLayoutRoute(),
      // home: PaddingLayout(),
      // home: DecoratedBoxLayout(),
      // home: TransformLayout(),
      // home: TransformLayout1(),
      // home: TransformLayout2(),
      // home: TransformLayout3(),
      // home: ContainerLayout(),
      // home: ClipTestRoute(),
      // home: FittedBox(),     //未完成
      // home: ScaffoldRoute(),   //出现报错
      // home: SingleChildScrollViewTestRoute(),
      // home: ListViewLayout(),
      // home: CustomScrollView2(),
      home: CustomScrollView1(),
    );
  }
}

class CustomScrollView1 extends StatelessWidget {
  var listView = SliverFixedExtentList(
    itemExtent: 56,
    delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('$index')),
        childCount: 10),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("滚动列表"),
        ),
        body: CustomScrollView(
          slivers: [listView, listView],
        ));
  }
}

class CustomScrollView2 extends StatelessWidget {
  var listView = ListView.builder(
      itemCount: 20,
      itemBuilder: (_, index) => ListTile(
            title: Text('$index'),
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滚动列表"),
      ),
      body: Column(
        children: [
          Expanded(child: listView),
          Divider(
            color: Colors.grey,
          ),
          Expanded(child: listView)
        ],
      ),
    );
  }
}

// class TabViewRoute1 extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _TabViewRoute1State();
//   }
// }
//
// class _TabViewRoute1State extends State<TabViewRoute1>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List tabs = ["新闻", "历史", "图片"];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: tabs.length, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("App Name"),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: tabs.map((e) => Tab(text: e)).toList(),
//         ),
//       ),
//       body: TabBarView( //构建
//         controller: _tabController,
//         children: tabs.map((e) {
//           return KeepAliveWrapper(
//             child: Container(
//               alignment: Alignment.center,
//               child: Text(e, textScaleFactor: 5),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // 释放资源
//     _tabController.dispose();
//     super.dispose();
//   }
// }

class ListViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("列表"),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemExtent: 50.0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("$index"));
          }),
    );
  }
}

class SingleChildScrollViewTestRoute extends StatelessWidget {
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滑动组件"),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: str
                  .split("")
                  .map((c) => Text(
                        c,
                        textScaleFactor: 2.0,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

// class MyDrawer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: MediaQuery.removePadding(
//         context: context,
//         removeTop: true,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 38.0),
//               child: Row(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: ClipOval(
//                       child: Image.asset(
//                         "imgs/avatar.png",
//                         width: 80,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     "Wendux",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//                 child: ListView(
//               children: <Widget>[
//                 ListTile(
//                   leading: const Icon(Icons.add),
//                   title: const Text('Add account'),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.settings),
//                   title: const Text('Manage accounts'),
//                 )
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ScaffoldRoute extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ScaffoldRoute();
//   }
// }
//
// class _ScaffoldRoute extends State<ScaffoldRoute> {
//   int _selectedIndex = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("App Name"),
//         actions: <Widget>[
//           IconButton(onPressed: () {}, icon: Icon(Icons.share))
//         ],
//       ),
//       drawer: MyDrawer(),
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home)), //报错 具体原因不明
//           BottomNavigationBarItem(icon: Icon(Icons.home)),
//           BottomNavigationBarItem(icon: Icon(Icons.home)),
//         ],
//         currentIndex: _selectedIndex,
//         fixedColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: _onAdd,
//       ),
//     );
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   void _onAdd() {}
// }

//子组件适配父组件      待回头再看 不明白组件封装的具体写法
class FittedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("空间适配"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

//不清楚这种方式的正确写法
// Widget wContainer(BoxFit boxFit){
//   return Container(
//     width: 50,
//     height: 50,
//     color: Colors.red,
//     child: FittedBox(
//       fit: boxFit,
//       // 子容器超过父容器大小
//       child: Container(width: 60, height: 70, color: Colors.blue),
//     ),
//   );
// }

//自定义MyClipper  提示报错 暂时还不明白
// class CustomClipper extends StatelessWidget{
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
//
// }

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget avatar = Image.asset("images/avatar.png", width: 60.0);
    return Scaffold(
      appBar: AppBar(
        title: Text("裁剪"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            avatar,
            ClipOval(
              child: avatar,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: avatar,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5,
                  child: avatar,
                ),
                Text(
                  "你好世界",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: 0.5,
                    child: avatar,
                  ),
                ),
                Text(
                  "你好世界",
                  style: TextStyle(color: Colors.green),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//多功能容器组件   组合优于继承
class ContainerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("多容器组件"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 120.0),
        constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
        decoration: BoxDecoration(
          gradient: RadialGradient(
              colors: [Colors.red, Colors.orange],
              center: Alignment.topLeft,
              radius: .98),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0)
          ],
        ),
        transform: Matrix4.rotationZ(.2),
        alignment: Alignment.center,
        child: Text(
          "5.20",
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
      ),
    );
  }
}

//变换 绘制阶段       布局阶段
class TransformLayout3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("缩放Layout"),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Transform.scale(
          scale: 1.5,
          child: Text("Hello World"),
        ),
      ),
    );
  }
}

class TransformLayout2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("旋转Layout"),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Transform.rotate(
          angle: math.pi / 2,
          child: Text("Hello World"),
        ),
      ),
    );
  }
}

class TransformLayout1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("变换Layout"),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: Transform.translate(
          offset: Offset(-200.0, -50.0),
          child: Text("Hello World"),
        ),
      ),
    );
  }
}

class TransformLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("变换Layout"),
      ),
      body: Container(
        color: Colors.black,
        child: Transform(
          alignment: Alignment.topRight,
          transform: Matrix4.skewY(0.3),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.deepOrange,
            child: const Text('Apartment for rent!'),
          ),
        ),
      ),
    );
  }
}

class DecoratedBoxLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("装饰"),
      ),
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.red, Colors.orange.shade700]),
              borderRadius: BorderRadius.circular(3.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class PaddingLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Padding布局"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text("Hello world"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text("I am Jack"),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Text("Your friend"),
            )
          ],
        ),
      ),
    );
  }
}

class AfterLayoutRoute extends StatefulWidget {
  const AfterLayoutRoute({Key? key}) : super(key: key);

  @override
  _AfterLayoutRoute createState() => _AfterLayoutRoute();
}

class _AfterLayoutRoute extends State<AfterLayoutRoute> {
  String _text = 'flutter 实战 ';
  Size _size = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return GestureDetector(
                    child: Text(
                      'text1: 点击获取我的大小',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => print('text1:${context.size}'),
                  );
                },
              )),
        ],
      ),
    );
  }
}

//需要补充自定义组件的知识 再来完善这里的代码
class LayoutBuilderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, Text("A"));
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello World"),
      ),
      body: Column(
        children: [
          SizedBox(
              width: 190,
              child: ResponsiveColumn(
                children: _children,
              )),
          ResponsiveColumn(children: _children),
          // LayoutLogPrint(child:Text("xx"))
        ],
      ),
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveColumn({required this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 200) {
          return Column(
            children: children,
            mainAxisSize: MainAxisSize.min,
          );
        } else {
          var _children = <Widget>[];
          for (var i = 0; i < _children.length; i += 2) {
            if (i + 1 < children.length) {
              _children.add(Row(
                children: [children[i], children[i + 1]],
                mainAxisSize: MainAxisSize.min,
              ));
            } else {
              _children.add(_children[i]);
            }
          }
          return Column(children: _children, mainAxisSize: MainAxisSize.min);
        }
      },
    );
  }
}

class StackLayout2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Stack3"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 120.0,
              width: 120.0,
              color: Colors.blue.shade50,
              child: Align(
                alignment: Alignment.topRight,
                child: FlutterLogo(
                  size: 60,
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                child: Text("decorated"),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                widthFactor: 1,
                heightFactor: 1,
                child: Text("decoratedBox"),
              ),
            )
          ],
        ));
  }
}

class StackLayout1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("stack 布局"),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand, //未定位的widget 会占满 整个Stack整个空间
        children: <Widget>[
          Positioned(left: 18.0, child: Text("I am Jack")),
          Container(
            child: Text("Text world", style: TextStyle(color: Colors.white)),
            color: Colors.red,
          ),
          Positioned(
            top: 18.0,
            child: Text("Your friend"),
          )
        ],
      ),
    );
  }
}

class StackLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("帧布局"),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: Text("Hello world", style: TextStyle(color: Colors.white)),
              color: Colors.red,
            ),
            Positioned(
              left: 19.0,
              child: Text("I am Jack"),
            ),
            Positioned(
              top: 18.0,
              child: Text("Your friend"),
            )
          ],
        ),
      ),
    );
  }
}

//flow布局 后续再训练
// class FlowLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flow布局"),
//       ),
//       body: Flow(
//         // delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
//         // children: <Widget>[
//         //   Container(width: 80.0, height: 80.0, color: Colors.red,),
//         //   Container(width: 80.0, height: 80.0, color: Colors.green,),
//         //   Container(width: 80.0, height: 80.0, color: Colors.blue,),
//         //   Container(width: 80.0, height: 80.0, color: Colors.yellow,),
//         //   Container(width: 80.0, height: 80.0, color: Colors.brown,),
//         //   Container(width: 80.0, height: 80.0, color: Colors.purple,),
//         // ],
//       ),
//     );
//   }
// }
//
// class TestFlowDelegate extends FlowDelegate {
//
//   late EdgeInsets margin;
//
//   // TestFlowDelegate(EdgeInsets margin) {
//   //   this.margin = margin;
//   // }
//
//   double width = 0;
//   double height = 0;
//
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     var x = margin.left;
//     var y = margin.top;
//     for (int i = 0; i < context.childCount; i++) {
//       var w = context.getChildSize(i)!.width + x + margin.right;
//       if (w < context.size.width) {
//         context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
//         x = w + margin.left;
//       } else {
//         x = margin.left;
//         y += context.getChildSize(i)!.height + margin.top + margin.bottom;
//         context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
//         x += context.getChildSize(i)!.width + margin.left + margin.right;
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant FlowDelegate oldDelegate) {
//     return oldDelegate != this;
//   }
//
//   @override
//   Size getSize(BoxConstraints constraints) {
//     return Size(double.infinity, 200.0);
//   }
// }

class WrapLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Warp布局"),
      ),
      body: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        alignment: WrapAlignment.center,
        children: <Widget>[
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('A'),
            ),
            label: Text("Hamilton"),
          ),
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('M'),
            ),
            label: Text('Lafayette'),
          ),
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('H'),
            ),
            label: Text('Mulligan'),
          ),
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('J'),
            ),
            label: Text('Launrens'),
          )
        ],
      ),
    );
  }
}

class FlexLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flex布局"),
      ),
      body: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 100.0,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: Container(
                          height: 30.0,
                          color: Colors.red,
                        ),
                      )),
                  Spacer(
                    //Spacer：功能-占用指定比例的空间
                    flex: 1,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 30.0,
                        color: Colors.green,
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ColumnLayout2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线性布局Column2"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: Container(
              color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[Text("hello world "), Text("I am Jack ")],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class ColumnLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线性布局Column"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Text("hi"), Text("world")],
      ),
    );
  }
}

class RowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("线性布局"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //子组件在纵轴方向的对齐方式
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("Hello world "), Text(" I am Jack ")],
          ),
          Row(
            mainAxisSize: MainAxisSize.min, //此时，mainAxisAlignment属性无意义
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(" hello world "),
              Text(" I am Jack "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Text(" hello world "),
              Text(" I am Jack "),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Text(
                " hello world ",
                style: TextStyle(fontSize: 30.0),
              ),
              Text(" I am Jack "),
            ],
          )
        ],
      ),
    );
  }
}

class BoxLayout extends StatelessWidget {
  Widget redBox = DecoratedBox(decoration: BoxDecoration(color: Colors.red));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("盒子布局"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: double.infinity, minHeight: 50.0),
          child: Container(
            height: 5.0,
            child: redBox,
          ),
        ),
      ),
    );
  }
}

class InputWidget extends StatefulWidget {
  @override
  State<InputWidget> createState() => _InputWidget();
}

class _InputWidget extends State<InputWidget> {
  TextEditingController _unameController = TextEditingController();

  @override
  void initState() {
    // super.initState();
    _unameController.addListener(() {
      print(_unameController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("输入框UI"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: _unameController,
              onChanged: (v) {
                print("onChange: $v");
              },
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person),
                  // enabledBorder: UnderlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.grey)),
                  // focusedBorder: UnderlineInputBorder(
                  //     borderSide: BorderSide(color: Colors.blue)),
                  border: InputBorder.none),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("登录"),
                    ),
                    onPressed: () {},
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // String icons = "";
    // icons += "\uE03e";
    // icons += " \uE237";
    // icons += " \uE287";
    //
    // return Text(
    //   icons,
    //   style: TextStyle(
    //     fontFamily: "MaterialIcons",
    //     fontSize: 20.0,
    //     color: Colors.green,
    //   ),
    // );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.accessible,
          color: Colors.green,
        ),
        Icon(
          Icons.error,
          color: Colors.green,
        ),
        Icon(
          Icons.fingerprint,
          color: Colors.green,
        )
      ],
    );
  }
}

class ImageAndIconRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var img = AssetImage("images/avatar.png");
    return SingleChildScrollView(
      child: Column(
        children: <Image>[
          Image(
            image: img,
            height: 50.0,
            width: 100.0,
            fit: BoxFit.fill,
          ),
          Image(
            image: img,
            height: 50.0,
            width: 100.0,
            fit: BoxFit.contain,
          ),
          Image(
            image: img,
            height: 50,
            width: 50.0,
            fit: BoxFit.contain,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.fitWidth,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 50.0,
            fit: BoxFit.scaleDown,
          ),
          Image(
            image: img,
            height: 50.0,
            width: 100.0,
            fit: BoxFit.none,
          ),
          Image(
            image: img,
            width: 100.0,
            color: Colors.blue,
            colorBlendMode: BlendMode.difference,
            fit: BoxFit.fill,
          ),
          Image(
            image: img,
            width: 100.0,
            height: 200.0,
            repeat: ImageRepeat.repeatY,
          )
        ].map((e) {
          return Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 100,
                  child: e,
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // Text(
            //   // '$_counter',
            //   // style: Theme.of(context).textTheme.headline4,
            //   "Hello World",
            //   style: TextStyle(
            //     color: Colors.blue,
            //     fontSize: 18.0,
            //     height: 1.2,
            //     fontFamily: "Courier",
            //     background: Paint()..color=Colors.yellow,
            //     decoration: TextDecoration.underline,
            //     decorationStyle: TextDecorationStyle.dashed
            //   ),
            // ),

            // Text.rich(TextSpan(
            //   children: [
            //     TextSpan(
            //       text: "Home: "
            //     ),
            //     TextSpan(
            //       text: "https://flutterchina.club",
            //       style: TextStyle(
            //         color: Colors.blue
            //       ),
            //       // recognizer:
            //     )
            //   ]
            // ))

            // DefaultTextStyle(
            //     style: TextStyle(
            //       color: Colors.red,
            //       fontSize: 20.0,
            //     ),
            //     textAlign: TextAlign.start,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Text("hello world"),
            //         Text("I am Jack"),
            //         Text(
            //           "I am Jack",
            //           style: TextStyle(inherit: false, color: Colors.grey),
            //         )
            //       ],
            //     )
            // )

            // ElevatedButton(onPressed: () {}, child: Text("normal"))

            // TextButton(onPressed: (){}, child: Text("normal"))

            // OutlinedButton(onPressed: (){}, child: Text("normal"))

            // IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up))

            // ElevatedButton.icon(
            //   icon:Icon(Icons.send),
            //   label:Text("发送"),
            //   onPressed: (){},
            // )

            // OutlinedButton.icon(
            //     onPressed: () {}, icon: Icon(Icons.add), label: Text("添加")
            // )

            // TextButton.icon(onPressed: (){}, icon: Icon(Icons.add), label: Text("添加"))
            // Image(
            //   image: AssetImage("images/avatar.png"), //加载不出来
            //   width: 100.0,
            // ),
            //
            // Image(
            //   image: NetworkImage(
            //       "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
            //   width: 100.0,
            // ),

            // Image.network(
            //   "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
            //   width: 100.0,
            //   height: 50.0,
            //   fit: BoxFit.fill,
            // ),
            // Image.network(
            //   "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
            //   width: 100.0,
            //   height: 50.0,
            //   fit: BoxFit.contain,
            // ),
            // Image.network(
            //   "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
            //   width: 100.0,
            //   height: 50.0,
            //   fit: BoxFit.cover,
            // ),
            // Image.network(
            //   "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
            //   width: 100.0,
            //   fit: BoxFit.fitWidth,
            //   height: 50.0,
            // ),
            // Image.network(
            //   "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
            //   width: 100.0,
            //   fit: BoxFit.fitHeight,
            //   height: 50.0,
            // ),
            // Image.network(
            //   "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
            //   width: 100.0,
            //   fit: BoxFit.scaleDown,
            //   height: 50.0,
            // ),
            // Image.network(
            //   "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
            //   width: 100.0,
            //   height: 50.0,
            //   fit: BoxFit.none,
            // )

            // Image(
            //   image: AssetImage("images/avatar.png"),
            //   width: 100.0,
            //   color: Colors.blue,
            //   colorBlendMode: BlendMode.difference,
            // )

            Image(
              image: AssetImage("images/avatar.png"),
              width: 100.0,
              height: 200.0,
              repeat: ImageRepeat.repeatY,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
