import 'package:flutter_simple/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> topProviders = [
  //2.创建一个provider
  ChangeNotifierProvider(create: (_) => ThemeProvider())
];
