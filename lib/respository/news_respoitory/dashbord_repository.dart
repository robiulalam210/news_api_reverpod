import 'dart:convert';


import '../../data/network/NetworkApiService.dart';
import '../../model/bannerlist_model.dart';
import '../../res/app_url/urls_and_app_constants.dart';


class DashbordRepository {
  final apiService = NetworkApiServices();

  Future<List<NewsListModel>> getbanner() async {
    dynamic response =
        await apiService.getApi(AppUrls.DASHBOARD_BANNER);

    var jsonData = response['articles'];
    var jsonDataEncode = jsonEncode(jsonData);
    print(jsonData);
    return newsListModelFromJson(jsonDataEncode);
  }

}


