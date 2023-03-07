import 'package:f_util_go/util/string_util.dart';
import 'package:flutter/material.dart';
import '../fnavigator/fn_navigator.dart';
import '../widget/appbar.dart';
import '../widget/login_button.dart';
import '../widget/login_effect.dart';
import '../widget/login_input.dart';

///登录页面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {
        // FnNavigator.getInstance().onJumpTo(RouteStatus.registration);
        FnNavigator.getInstance().onJumpTo(RouteStatus.home);
      }),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(protect: protect),
            LoginInput(
              '用户名',
              '请输入用户',
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true,
              onChanged: (text) {
                password = text;
                checkInput();
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: LoginButton(
                  '登录',
                  enable: loginEnable,
                  onPressed: send,
                ))
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  // void send() async {
  void send() {
    print("导航框架 6 send");
    // 跳转逻辑
    FnNavigator.getInstance().onJumpTo(RouteStatus.home);

    // print("object");
    // try {
    //   var result = await UserDao.login(userName!, password!);
    //
    //   if (result['code'] == 0) {
    //     print('登录成功');
    //   } else {
    //     print(result['msg']);
    //   }
    // } on NeedAuth catch (e) {
    //   print(e);
    // } on FwNetError catch (e) {
    //   print(e);
    // }
  }
}
