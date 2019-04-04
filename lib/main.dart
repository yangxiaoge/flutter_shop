import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/constants/import.dart';

void main() {
  /// 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  var childCategory = ChildCategoryProvide();
  var categoryGoodsList = CategoryGoodsListProvide();
  var detailInfo = DetailsInfoProvide();
  var provides = Providers();
  provides
    ..provide(Provider<ChildCategoryProvide>.value(childCategory))
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList))
    ..provide(Provider<DetailsInfoProvide>.value(detailInfo));
  runApp(ProviderNode(
    providers: provides,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //fluro路由配置
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;

    return MaterialApp(
      title: Constants.appName,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        //https://stackoverflow.com/questions/50212484/what-is-the-difference-between-primarycolor-and-primaryswatch-in-flutter
        //通常最好定义一个primarySwatch而不是primaryColor。因为一些material组件可能会使用不同的阴影，primaryColor如阴影，边框，......
        primarySwatch: Colors.pink,
      ),
      home: IndexPage(),
      // home: TestInk(),
    );
  }
}

class TestInk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 260,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                child: GridView.count(crossAxisCount: 3, children: list()),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> list() {
    List<Widget> item = List();
    for (var i = 0; i < 6; i++) {
      item.add(InkWell(
        onTap: () {
          print('啊啊');
        },
        child: Center(
          child: ListTile(
            leading: Icon(Icons.free_breakfast),
            title: Text('item $i'),
          ),
        ),
      ));
    }

    return item;
  }
}

class SliverAppBarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // title: Text('YangXiaoGe'),
            floating: true,
            expandedHeight: 178,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Hello YangXiaoGe'.toUpperCase(),
                style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w400),
              ),
              background: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img12.360buyimg.com/img/jfs/t27721/23/2247952402/347624/b54d1539/5bfaa1e4N096ea6fc.jpg'),
                  ),
                ),
              ),
            ),
          ),
          SliverSafeArea(
            sliver: SliverPadding(
              padding: EdgeInsets.all(8),
              // sliver: SliverGridDemo(),
              sliver: SliverListDemo(),
            ),
          )
        ],
      ),
    );
    // return Text('哈哈');
  }

  Widget list() {
    List<Widget> item = List();
    for (var i = 0; i < 20; i++) {
      item.add(InkWell(
        child: ListTile(
          leading: Icon(Icons.free_breakfast),
          title: Text('item $i'),
        ),
      ));
    }

    return ListView(
      children: item,
    );
  }
}

class SliverGridDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.5),
        delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
              child: Image.network(
            'https://img11.360buyimg.com/img/jfs/t29431/350/673288794/347788/295ced43/5bfaa8c1Nd9d0e6a2.jpg',
            fit: BoxFit.cover,
          ));
        }, childCount: 20),
      ),
    );
  }
}

class SliverListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 14,
              shadowColor: Colors.grey.withOpacity(0.5),
              child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                        child: Image.network(
                      'https://resources.ninghao.org/images/candy-shop.jpg',
                      fit: BoxFit.cover,
                    )),
                  ),
                  Positioned(
                    left: 32,
                    top: 32,
                    child: Column(
                      children: <Widget>[Text('标题 $index')],
                    ),
                  )
                ],
              ),
            ),
          );
        }, childCount: 20),
      ),
    );
  }
}
