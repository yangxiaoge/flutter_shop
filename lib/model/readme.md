Json解析两种方式：

1. 可以用 json.decode字符串之后，根据节点名称获取，类似 data['data']['name'],详情可以看首页的解析

2. 还有一种就是类似于java，把json序列化成model对象，也就是本model目录的dart对象。