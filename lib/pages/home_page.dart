import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //FutureBuilder对应 future
  Future _future;

  //默认经纬度
  var formData = {'lon': '32.162746', 'lat': '118.703763'};

  //火爆商品页码
  int page = 1;

  //火爆商品list
  List<Map> goodsList = [];

  //listview滑动监听
  ScrollController _controller = new ScrollController();

  //显示floatingActionButton
  bool _showFloatBtn = false;

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  //获取火爆商品
  _requestHotGoods() {
    request(homePageBelowConten, formData: page).then((goodsItem) {
      debugPrint('page = $page');
      setState(() {
        //debugPrint('goodsItem = $goodsItem');
        //先decode成json
        var data = json.decode(goodsItem.toString());
        goodsList.addAll((data['data'] as List).cast());
        page++;
      });
    });
  }

  @override
  void initState() {
    //FutureBuilder 多次触发解决 https://www.jianshu.com/p/74e52aa09986
    _future = request(homePageContent, formData: formData);
    _requestHotGoods();

    //动态显示FloatingActionButton
    _controller.addListener(() {
      double pixels = _controller.position.pixels;
      bool show = pixels >= 480;
      if (_showFloatBtn != show) {
        setState(() {
          _showFloatBtn = show;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> topCategoryList =
                (data['data']['category'] as List).cast();
            String adPic = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImgUrl = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            String saomaUrl = data['data']['saoma']['PICTURE_ADDRESS'];
            String integralMallPicUrl =
                data['data']['integralMallPic']['PICTURE_ADDRESS'];
            String newUserUrl = data['data']['newUser']['PICTURE_ADDRESS'];
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast();

            String floor1TitleImgUrl =
                data['data']['floor1Pic']['PICTURE_ADDRESS'];
            List<Map> floor1Goods = (data['data']['floor1'] as List).cast();
            String floor2TitleImgUrl =
                data['data']['floor2Pic']['PICTURE_ADDRESS'];
            List<Map> floor2Goods = (data['data']['floor2'] as List).cast();
            String floor3TitleImgUrl =
                data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor3Goods = (data['data']['floor3'] as List).cast();

            return EasyRefresh(
              key: _easyRefreshKey,
              refreshHeader: BallPulseHeader(key: _headerKey),
              refreshFooter: BallPulseFooter(key: _footerKey),
              child: ListView(
                controller: _controller,
                children: <Widget>[
                  SwiperDiy(swiper),
                  TopGridView(topCategoryList),
                  AdBanner(adPic),
                  LeaderPhone(leaderPhone, leaderImgUrl),
                  TicketIntegral(saomaUrl, integralMallPicUrl, newUserUrl),
                  Recommend(recommendList),
                  FloorTitle(titleImgUrl: floor1TitleImgUrl),
                  FloorGoodsList(floorGoods: floor1Goods),
                  FloorTitle(titleImgUrl: floor2TitleImgUrl),
                  FloorGoodsList(floorGoods: floor2Goods),
                  FloorTitle(titleImgUrl: floor3TitleImgUrl),
                  FloorGoodsList(floorGoods: floor3Goods),
                  _hotGoods(context),
                ],
              ),
              onRefresh: () async {
                debugPrint('下拉刷新');
                await Future.delayed(Duration(seconds: 1), () {
                  setState(() {
                    //火爆商品页码重置，集合数据清除
                    page = 1;
                    goodsList.clear();
                    _requestHotGoods();
                  });
                });
              },
              loadMore: () async {
                debugPrint('加载更多...');
                await Future.delayed(Duration(seconds: 1), () {
                  _requestHotGoods();
                });
              },
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
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return _showFloatBtn
        ? FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              Icons.keyboard_arrow_up,
            ),
            onPressed: () {
              _controller.animateTo(0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.bounceIn);
            })
        : null;
  }

  ///火爆商品 title + list
  Widget _hotGoods(context) {
    return Column(
      children: <Widget>[
        _hotTitle(context),
        _goodsList(context),
      ],
    );
  }

  //title
  Widget _hotTitle(context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: Text(
        '火爆商品',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      decoration: BoxDecoration(
          color: Color.fromRGBO(244, 245, 245, 1.0),
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
    );
  }

  //火爆商品list
  Widget _goodsList(context) {
    return Wrap(
      children: goodsList.map((itemMap) {
        return InkWell(
          onTap: () {
            debugPrint('火爆商品item$itemMap');
          },
          child: Container(
            width: ScreenUtil.getInstance().setWidth(375),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            // margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(
                  itemMap['image'],
                  width: ScreenUtil().setWidth(375),
                ),
                Text(
                  itemMap['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ScreenUtil.getInstance().setSp(26)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: <Widget>[
                      Text('￥${itemMap['mallPrice']}'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '￥${itemMap['price']}',
                            style: TextStyle(
                                color: Colors.black26,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
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

  Widget _gridviewItem(item) {
    return InkWell(
      onTap: () {
        debugPrint('点击了导航$item');
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
        //关闭滑动效果
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridviewItem(item);
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
      child: InkWell(
        onTap: () {
          debugPrint('点击了横条广告');
        },
        child: Image.network(adPic),
      ),
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

///领券,积分商城
class TicketIntegral extends StatelessWidget {
  final String saomaUrl;
  final String integralMallPicUrl;
  final String newUserUrl;

  TicketIntegral(this.saomaUrl, this.integralMallPicUrl, this.newUserUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          _ticketIntetralItem(saomaUrl),
          _ticketIntetralItem(integralMallPicUrl),
          _ticketIntetralItem(newUserUrl),
        ],
      ),
    );
  }

  Widget _ticketIntetralItem(String imgUrl) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(250), // 750 / 3,设计稿是750*1334
      child: InkWell(
        onTap: () {
          debugPrint('点击了领券,积分商城');
        },
        child: Image.network(imgUrl),
      ),
    );
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
      padding: EdgeInsets.only(left: 10),
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
            Expanded(
              child: Image.network(recommendList[index]['image']),
            ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _titleWidget(),
          _horizontalListView(),
        ],
      ),
    );
  }
}

///楼层标题
class FloorTitle extends StatelessWidget {
  final String titleImgUrl;

  FloorTitle({Key key, this.titleImgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          debugPrint('点击了楼层标题');
        },
        child: Image.network(titleImgUrl),
      ),
    );
  }
}

///楼层商品列表
class FloorGoodsList extends StatelessWidget {
  final List floorGoods;

  FloorGoodsList({Key key, this.floorGoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(),
          _secondRow(),
        ],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoods[0]),
        Column(
          children: <Widget>[
            _goodsItem(floorGoods[1]),
            _goodsItem(floorGoods[2])
          ],
        )
      ],
    );
  }

  Widget _secondRow() {
    return Row(
      children: <Widget>[
        _goodsItem(floorGoods[3]),
        _goodsItem(floorGoods[4]),
      ],
    );
  }

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(375), // 750 / 2,设计稿是750*1334
      child: InkWell(
        onTap: () {
          debugPrint('点击了楼层商品');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
