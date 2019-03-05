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
            String leaderImgUrl = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast();
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SwiperDiy(swiper),
                  TopGridView(navigatorList),
                  AdBanner(adPic),
                  LeaderPhone(leaderPhone, leaderImgUrl),
                  Recommend(recommendList),
                ],
              ),
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
            swiperDataList[index]['image'],
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
          Text(item['mallCategoryName'])
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

/// 横条广告
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

/// 店长电话
class LeaderPhone extends StatelessWidget {
  final String phone;
  final String imgUrl;

  LeaderPhone(this.phone, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchUrl,
        child: Image.network(imgUrl),
      ),
    );
  }

  /// 拨打电话
  void _launchUrl() async {
    String url = 'tel:$phone';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'url不能访问，异常';
    }
  }
}

///商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend(this.recommendList);

  //商品标题
  Widget _titleWidget() {
    return Container(
      height: ScreenUtil.getInstance().setHeight(60),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      //设置下边框
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Text('商品推荐',
          style: TextStyle(
            color: Colors.pink,
          )),
    );
  }

  //商品子项部件
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil.getInstance().setWidth(250),
        height: ScreenUtil.getInstance().setHeight(330),
        padding: EdgeInsets.all(8),
        //设置左边框
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              //文字下滑线
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  //横向商品listview
  Widget _horizontalListView() {
    print(" recommendList.length = " + recommendList.length.toString());
    return Container(
      height: ScreenUtil.getInstance().setHeight(330),
      child: ListView.builder(
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //_titleWidget 高度 + _horizontalListView 高度
      height: ScreenUtil.getInstance().setHeight(390),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _horizontalListView(),
        ],
      ),
    );
  }
}
