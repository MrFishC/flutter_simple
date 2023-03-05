import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/dark_mode_item.dart';
import '../theme/theme_provider.dart';
import '../widget/login_input.dart';
///我的
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text('我的'),
            LoginInput(
              '用户名',
              '请输入用户',
              onChanged: (text) {},
            ),
            MaterialButton(
              onPressed: () {
                //read
                var theme = context.read<ThemeProvider>();

                if (theme.isDark()) {
                  theme.setTheme(ThemeMode.light);
                } else {
                  theme.setTheme(ThemeMode.dark);
                }
              },
              child: Text('切换模式'),
            ),
            DarkModelItem()
          ],
        ),
      ),
    );
  }
}
