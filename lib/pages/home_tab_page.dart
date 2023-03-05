import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../api/video.dart';
import '../dao/home_dao.dart';
import '../model/home_model.dart';
import '../model/video_model.dart';
import '../util/color.dart';
import '../widget/banner.dart';
import '../widget/video_card.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int pageIndex = 1;
  int pageSize = 10;
  List<HomeMo> data = [];

  List<VideoModel> _videos = videos.toList();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      //你当前数据填充后的最大长度
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      if (dis < 300) {
        print("小于300尺寸");
        _loadData(loadMore: true);
      }
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
          onRefresh: _loadData,
          color: primary,
          // 通过MediaQuery.removePadding可以移除元素的pandding
          child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  //设置滑动效果  注意点，ListView在使用这个属性时，需要将itemview充满整个ListView才会出现对应的效果  这里可能也有类似问题
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  crossAxisCount: 2,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    //有banner时第一个item位置显示banner
                    if (data != null && index == 0) {
                      return Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: _banner());
                    } else {
                      return VideoCard(videoMo: _videos[index]);
                    }
                  },
                  staggeredTileBuilder: (int index) {
                    if (data != null && index == 0) {
                      return StaggeredTile.fit(2);
                    } else {
                      return StaggeredTile.fit(1);
                    }
                    // return StaggeredTile.fit(2);
                  }))),
    );
  }

  _banner() {
    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: FcBanner(data.sublist(0, 5)));
  }

  void loadData() async {
    List<HomeMo> homeData = await HomeDao.loadHomeRecommend(0);
    print("loadData   :$homeData");
  }

  ///loadMore 是否加载
  Future<void> _loadData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    List<HomeMo> homeData = await HomeDao.loadHomeRecommend(0,
        pageSize: pageSize, pageIndex: currentIndex);
    setState(() {
      data = [...data, ...homeData];
      if (homeData.isNotEmpty) {
        pageIndex++;
      }
    });
  }
}
