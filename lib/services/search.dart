import 'package:sop/model/search.dart';
import 'package:sop/utils/request.dart';

/// 搜索页面
class SearchAPI {
  /// 搜索数据
  static Future<SearchModel> searchData({required String keyword}) async {
    var response = await RequestUtil().get(
      '/search',
      params: {"keyword": keyword},
    );
    return SearchModel.fromJson(response);
  }
}
