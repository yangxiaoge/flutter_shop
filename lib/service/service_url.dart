// easy-mock 测试地址
//const String baseUrl = 'https://easy-mock.com/mock/5c7cb5f7c64b7d04d10c1e09/shop_flutter/';
//fastmock
//const String baseUrl = 'https://www.fastmock.site/mock/58fe9bc52b7283b676eb1d8f42201f93/fluttershop/';

// 百姓生活+ 技术胖接口
 const String baseUrl = 'http://v.jspang.com:8088/baixing/';
// 微信小程序抓取的接口
// const String baseUrl = 'http://wxmini.baixingliangfan.cn/baixing/';

const servicePath = {
  homePageContent: 'wxmini/homePageContent',
  homePageBelowConten: 'wxmini/homePageBelowConten',
  category: 'wxmini/getCategory',
  getMallGoods: 'wxmini/getMallGoods',
  getGoodDetailById: 'wxmini/getGoodDetailById',
};

//商店首页信息
const String homePageContent = 'homePageContent';
//商店首页火爆商品
const String homePageBelowConten = 'homePageBelowConten';
//获取商品分类
const String category = 'category';
//获取商品列表
const String getMallGoods = 'getMallGoods';
//商品详情页
const String getGoodDetailById = 'getGoodDetailById';

//服务接口对应名称
const Map serviceName = {
  homePageContent: '首页信息',
  homePageBelowConten: '首页火爆商品',
  category: '商品分类',
  getMallGoods: '商品列表',
  getGoodDetailById: '商品详情',
};
//获取服务器名称
String getServiceName(urlKey) {
  try {
    return serviceName[urlKey];
  } catch (e) {
    print('找不到接口名称');
    return '';
  }
}
