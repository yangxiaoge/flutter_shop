import 'package:flutter/material.dart';
import 'package:flutter_shop/constants/import.dart';
import 'package:flutter_easyrefresh/delivery_header.dart';
// import 'package:flutter_easyrefresh/taurus_footer.dart';
// import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightTopCategoryNav(),
                MallGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

///左侧商品分类
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> list = [];

  //当前左侧分类选中的下标
  int _selectLeftCategoryIndex = 0;

  void initState() {
    super.initState();
    _getCategory();
    //为了第一次能加载商品列表
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(200),
      child: ListView.separated(
        itemCount: list.length,
        itemBuilder: (context, index) => _leftInkWellItem(index),
        separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
              height: 1,
            ),
      ),
    );
  }

  Widget _leftInkWellItem(index) {
    return InkWell(
      onTap: () {
        //同一个tab多次点击忽略不处理
        if (_selectLeftCategoryIndex != index) {
          setState(() {
            _selectLeftCategoryIndex = index;
          });

          var childLsit = list[index].bxMallSubDto;
          var categoryId = list[index].mallCategoryId;
          //更新右上角商品分类
          Provide.value<ChildCategoryProvide>(context)
              .setChildCategory(childLsit, categoryId);

          //右上角分类滚动到下标0位置
          if (_controller.hasClients) {
            _controller.animateTo(0,
                duration: Duration(milliseconds: 200), curve: Curves.ease);
          }

          //商品列表请求
          _getGoodsList(categoryId: categoryId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: _selectLeftCategoryIndex == index
                ? Color.fromRGBO(236, 238, 239, 1.0)
                : Colors.white,
            border:
                Border(right: BorderSide(width: 0.5, color: Colors.black12))),
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 8),
        alignment: Alignment.centerLeft,
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(30)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request(category).then((val) {
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });

      //设置右上角分类默认项
      Provide.value<ChildCategoryProvide>(context)
          .setChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  _getGoodsList({String categoryId}) async {
    //categoryId: 大类 ID，字符串类型
    //categorySubId : 子类 ID，字符串类型，如果没有可以填写空字符串，例如 ''
    //page: 分页的页数，int 类型
    var formData = {
      'categoryId': categoryId ?? '4',
      'categorySubId': '',
      'page': 1
    };
    await request(getMallGoods, formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);

      //provide通知刷新商品列表
      Provide.value<CategoryGoodsListProvide>(context)
          .setCategoryGoodsList(categoryGoodsListModel.data ?? []); //判空
    });
  }
}

///右上角商品分类滚动监听
ScrollController _controller = new ScrollController();

///右上角商品分类
class RightTopCategoryNav extends StatefulWidget {
  @override
  __RightTopCategoryNavState createState() => __RightTopCategoryNavState();
}

class __RightTopCategoryNavState extends State<RightTopCategoryNav> {
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategoryProvide>(
      builder: (context, child, childCategory) => Container(
            width: ScreenUtil().setWidth(550),
            height: ScreenUtil().setHeight(90),
            child: ListView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) => _rightInkWellItem(
                  index, childCategory.childCategoryList[index]),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 1))),
          ),
    );
  }

  Widget _rightInkWellItem(int index, BxMallSubDto item) {
    //当前下标是否被选中
    bool isSelected =
        Provide.value<ChildCategoryProvide>(context).selectChildCategoryIndex ==
            index;
    return InkWell(
      onTap: () {
        //同一个tab多次点击忽略不处理
        if (Provide.value<ChildCategoryProvide>(context)
                .selectChildCategoryIndex !=
            index) {
          Provide.value<ChildCategoryProvide>(context)
              .setChildSelectCategoryIndex(index, item.mallSubId);

          //商品列表请求
          _getGoodsList(item.mallSubId);
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 5,
        ),
        alignment: Alignment.center,
        child: Text(item.mallSubName,
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(30),
              color: isSelected ? Theme.of(context).primaryColor : Colors.black,
            )),
      ),
    );
  }

  _getGoodsList(String categorySubId) async {
    var formData = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };
    await request(getMallGoods, formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);

      //provide通知刷新商品列表
      Provide.value<CategoryGoodsListProvide>(context)
          .setCategoryGoodsList(categoryGoodsListModel.data ?? []); //判空
    });
  }
}

///商品列表
class MallGoodsList extends StatefulWidget {
  @override
  _MallGoodsListState createState() => _MallGoodsListState();
}

class _MallGoodsListState extends State<MallGoodsList> {
  //商品列表滚动监听
  ScrollController _goodsListController = new ScrollController();

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  @override
  void dispose() {
    _goodsListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, _, data) {
        try {
          if (Provide.value<ChildCategoryProvide>(context).goodsListPage == 1) {
            //商品列表滚动到下标0位置
            if (_goodsListController.hasClients) {
              _goodsListController.animateTo(0,
                  duration: Duration(milliseconds: 10), curve: Curves.ease);
            }
          }
        } catch (e) {
          print('进入页面第一次初始化:$e');
        }

        if (data.childCategoryGoodsList.length == 0) {
          return Text('暂时没有商品数据~');
        }
        return Expanded(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(550),
            child: EasyRefresh(
              key: _easyRefreshKey,
              refreshHeader: DeliveryHeader(key: _headerKey),
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Theme.of(context).primaryColor,
                moreInfoColor: Theme.of(context).primaryColor,
                showMore: false,
                loadText: '上拉加载',
                loadReadyText: '释放加载',
                loadingText: '正在加载',
                loadedText: '加载结束',
                noMoreText:
                    Provide.value<ChildCategoryProvide>(context).noMoreText,
              ),
              child: _goodsList(data.childCategoryGoodsList),
              onRefresh: () async {
                debugPrint('下拉刷新');
                await Future.delayed(Duration(seconds: 1), () {});
              },
              loadMore: () async {
                debugPrint('加载更多...');
                await Future.delayed(Duration(seconds: 1), () {
                  _getMoreGoodsList();
                });
              },
            ),
          ),
        );
      },
    );
  }

  _getMoreGoodsList() async {
    //page增加
    Provide.value<ChildCategoryProvide>(context).addPage();

    var formData = {
      'categoryId': Provide.value<ChildCategoryProvide>(context).categoryId,
      'categorySubId':
          Provide.value<ChildCategoryProvide>(context).categorySubId,
      'page': Provide.value<ChildCategoryProvide>(context).goodsListPage,
    };
    await request(getMallGoods, formData: formData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel categoryGoodsListModel =
          CategoryGoodsListModel.fromJson(data);

      //provide通知刷新商品列表
      if (categoryGoodsListModel.data == null) {
//        ToastHelper.showCenterShortToast('没有更多了');
        Toast.show(context, '没有更多了');
        Provide.value<ChildCategoryProvide>(context).changeNomoreText('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .setCategoryMoreGoodsList(categoryGoodsListModel.data);
      }
    });
  }

  Widget _goodsList(List goodsList) {
    return GridView.builder(
      controller: _goodsListController,
      scrollDirection: Axis.vertical,
      itemCount: goodsList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        CategoryListData goodsItem = goodsList[index];
        return InkWell(
          onTap: () {
            debugPrint('分类商品item: ${goodsItem.goodsName}');
            //查看商品详情
            Application.router.navigateTo(
                context, '${Routers.detailsPage}?id=${goodsItem.goodsId}');
          },
          child: Container(
            width: ScreenUtil.getInstance().setWidth(275),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    goodsItem.image,
                  ),
                ),
                Text(
                  goodsItem.goodsName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: ScreenUtil.getInstance().setSp(24)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '￥${goodsItem.oriPrice}',
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(24)),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '￥${goodsItem.presentPrice}',
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: ScreenUtil.getInstance().setSp(24),
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
      },
    );
  }
}
