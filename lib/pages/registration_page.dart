import 'package:flutter/material.dart';
import '../util/string_util.dart';
import '../widget/appbar.dart';
import '../widget/login_button.dart';
import '../widget/login_effect.dart';
import '../widget/login_input.dart';

///注册页面
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        // FwNavigator.getInstance().onJumpTo(RouteStatus.login);
      }),
      body: Container(
        child: ListView(
          //自适应键盘弹起，防止遮挡
          children: [
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              "用户名",
              "请输入用户名",
              onChanged: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              "密码",
              "请输入密码",
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
            LoginInput(
              "确认密码",
              "请再次输入密码",
              lineStretch: true,
              obscureText: true,
              onChanged: (text) {
                rePassword = text;
                checkInput();
              },
              focusChanged: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: LoginButton('注册',
                  enable: loginEnable, onPressed: checkParams),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    // try {
    //   var result =
    //       await LoginDao.registration(userName!, password!, imoocId!, orderId!);
    //   print(result);
    //   if (result['code'] == 0) {
    //     print('注册成功');
    //     showToast('注册成功');
    //     if (widget.onJumpToLogin != null) {
    //       widget.onJumpToLogin!();
    //     }
    //   } else {
    //     print(result['msg']);
    //     showWarnToast(result['msg']);
    //   }
    // } on NeedAuth catch (e) {
    //   print(e);
    //   showWarnToast(e.message);
    // } on FwNetError catch (e) {
    //   print(e);
    //   showWarnToast(e.message);
    // }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
