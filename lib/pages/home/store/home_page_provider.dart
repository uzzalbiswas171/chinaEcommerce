import 'package:flutter/foundation.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sop/model/goods.dart';
import 'package:sop/model/home.dart';
import 'package:sop/services/services.dart';

class HomePageProvider with ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool loading = true;
  List<String> banerList = [];
  List<BrandListElement> cateGoryList = [];
  List<BrandListElement> brandList = [];
  List<GoodsList> hotList = [];

  HomePageProvider() {
    /// 首页数据加载
    initData();
  }
  Future initData({bool refresh = false}) async {
    HomeModel res = await HomeAPI.getHomeData();

    /// 初次加载
    banerList = res.banerList;
    cateGoryList = res.cateGoryList;
    brandList = res.brandList;
    hotList = res.hotList;
    loading = false;

    /// 下拉刷新
    if (refresh) {
      banerList = res.banerList;
      cateGoryList = res.cateGoryList;
      brandList = res.brandList;
      hotList = res.hotList;
      loading = false;
      refreshController.refreshCompleted();
    }
    notifyListeners();
  }

  /// 上拉加载
  Future loadData({bool refresh = false}) async {
    HomeModel res = await HomeAPI.getHomeData();
    hotList += res.hotList;
    loading = false;
    if (hotList.length < 20) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
    notifyListeners();
  }
}
