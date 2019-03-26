// easy-mock 测试地址
//  const String baseUrl = 'https://easy-mock.com/mock/5c7cb5f7c64b7d04d10c1e09/shop_flutter';
// 百姓生活+ 接口
const String baseUrl = 'http://61.163.2.122/baixing/';

const servicePath = {
  homePageContent: 'wxmini/homePageContent',
  homePageBelowConten: 'wxmini/homePageBelowConten',
  category: 'wxmini/getCategory',
  getMallGoods: 'wxmini/getMallGoods',
};

//商店首页信息
const String homePageContent = 'homePageContent';
//商店首页火爆商品
const String homePageBelowConten = 'homePageBelowConten';
//获取商品分类
const String category = 'category';
//获取商品列表
const String getMallGoods = 'getMallGoods';

//服务接口对应名称
const Map serviceName = {
  homePageContent: '首页信息',
  homePageBelowConten: '首页火爆商品',
  category: '商品分类',
  getMallGoods: '商品列表',
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
