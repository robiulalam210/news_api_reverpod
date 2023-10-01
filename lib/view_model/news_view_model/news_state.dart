import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/bannerlist_model.dart';
import '../../respository/news_respoitory/dashbord_repository.dart';

final newsProvider =
    StateNotifierProvider<NewsNotifier, NewsState>((ref) => NewsNotifier());

@immutable
abstract class NewsState {}

class InitialNewsState extends NewsState {}

class NewsLoadingNewsState extends NewsState {}

class NewsLoadedNewsState extends NewsState {
  final List<NewsListModel> banner;

  NewsLoadedNewsState({required this.banner});
}

class ErrorNewsState extends NewsState {
  ErrorNewsState({required this.message});

  final String message;
}

class NewsNotifier extends StateNotifier<NewsState> {
  NewsNotifier() : super(InitialNewsState());
  final api = DashbordRepository();

  void fetchNews() async {
    try {
      state = NewsLoadingNewsState();
      List<NewsListModel> news = await api.getbanner();
      state = NewsLoadedNewsState(banner: news);
    } catch (e) {
      state = ErrorNewsState(message: e.toString());
    }
  }
}
