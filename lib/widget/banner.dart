import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import '../model/home_model.dart';
import '../model/profile_mo.dart';

//自定义banner
class FcBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  // final List<HomeMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;

  const FcBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    // Swiper:轮播组件
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      //自定义指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6)),
    );
  }

  _image(BannerMo bannerMo) {
  // _image(HomeMo bannerMo) {
    return InkWell(
      onTap: () {
        print(bannerMo.title);
        // handleBannerClick(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          // child: Image.network(bannerMo.pic ?? "", fit: BoxFit.cover),
          child: Image.network(bannerMo.cover ?? "", fit: BoxFit.cover),
        ),
      ),
    );
  }
}
