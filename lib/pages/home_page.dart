import 'package:flutter/material.dart';
import '../constants/import.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = '正在获取数据';

  //好像没有作用
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getHomePageContent().then((data) {
      print('首页商品信息 = $data');
      setState(() {
        homePageContent = data.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String adPic = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            return Column(
              children: <Widget>[
                SwiperDiy(swiper),
                TopGridView(navigatorList),
                AdBanner(adPic),
              ],
            );
          } else {
            return Center(
              child: Text(
                '加载中...',
                style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28)),
              ),
            );
          }
        },
      ),
    );
  }
}

/// 首页轮播控件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy(this.swiperDataList);
  @override
  Widget build(BuildContext context) {
    return Container(
      //图片高度像素
      height: ScreenUtil.getInstance().setHeight(333),
      width: ScreenUtil.getInstance().setWidth(750),
      child: Swiper(
        itemCount: swiperDataList.length,
        itemBuilder: (context, index) {
          return Image.network(
            '${swiperDataList[index]['image']}',
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

/// 顶部分类GridView
class TopGridView extends StatelessWidget {
  final List navigatorList;
  Widget _gridviewItem(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航$item');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil.getInstance().setWidth(95),
          ),
          Text('${item['mallCategoryName']}')
        ],
      ),
    );
  }

  TopGridView(this.navigatorList);

  @override
  Widget build(BuildContext context) {
    //删除超过10的部分
    if (this.navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      height: ScreenUtil.getInstance().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridviewItem(context, item);
        }).toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final String adPic;

  AdBanner(this.adPic);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPic),
    );
  }
}
