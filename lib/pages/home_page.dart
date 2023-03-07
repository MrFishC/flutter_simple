import 'package:f_net_go/exception/fn_error.dart';
import 'package:f_util_go/util/color.dart';
import 'package:f_util_go/util/toast.dart';
import 'package:f_util_go/util/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple/core/fw_state.dart';
import 'package:provider/provider.dart';
import 'package:underline_indicator/underline_indicator.dart';
import '../api/types.dart';
import '../api/video.dart';
import '../model/video_model.dart';
import '../theme/theme_provider.dart';
import '../util/navigation_bar.dart';
import '../widget/loading_container.dart';
import 'home_tab_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends FwState<HomePage>
    with AutomaticKeepAliveClientMixin,
    TickerProviderStateMixin,WidgetsBindingObserver{
  var listener;
  // List<HomeMo>? data = [];
  List<VideoModel> data = videos.toList();

  late TabController _controller;
  var tid = 0;
  // var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];
  var tabs = types.keys.toList();

  bool _isLoading = true;

  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabs.length, vsync: this);
    // FnNavigator.getInstance().addListener(this.listener = (current, pre) {
    //   if (widget == current.page || current.page is HomePage) {
    //     print('打开了首页:onResume');
    //   } else if (widget == pre?.page || pre?.page is HomePage) {
    //     print('首页:onPause');
    //   }
    // });

    loadData(tid);
  }

  /// 监听系统变化
  @override
  void didChangePlatformBrightness() {
    context.read<ThemeProvider>().darModeChange();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    // FnNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          children: [
            NavigationBarPlus(
              height: 50,
              child: _appBar(),
              color: Colors.white,
              statusStyle: StatusStyle.DARK_CONTENT,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 5),
              child: _tabBar(),
            ),
            Flexible(
                child: TabBarView(
                    controller: _controller,
                    children: tabs.map((tab) {
                      return HomeTabPage(
                        name: tab,
                        bannerList: videos.isNotEmpty
                            ? videos.toList().sublist(0, 5)
                            : videos.toList(),
                        tid: tid,
                      );
                    }).toList()))
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  ///自定义顶部tab
  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: UnderlineIndicator(
            strokeCap: StrokeCap.round,
            borderSide: BorderSide(color: primary, width: 3),
            insets: EdgeInsets.only(left: 15, right: 15)),
        tabs: tabs.map<Tab>((tab) {
          return Tab(
              child: Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Text(
              tab,
              style: TextStyle(fontSize: 16),
            ),
          ));
        }).toList());
  }

  void loadData(int tid, {loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    // List<HomeMo> homeData = await HomeDao.loadHomeRecommend(0);
    // print("===================data:$data");
    // setState(() {
    //   data = homeData;
    //   _isLoading = false;
    // });

    try {
      List<VideoModel> homeDatas = videos.toList();
      setState(() {
        if (mounted) {
          //合并
          data = [...data, ...homeDatas];
          if (homeDatas != null) {
            pageIndex++;
          }
          _isLoading = false;
        }
      });
    } on NeedAuth catch (e) {
      // print(e);
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on FnError catch (e) {
      // print(e);
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(Icons.search, color: Colors.grey),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
