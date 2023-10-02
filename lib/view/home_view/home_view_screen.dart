import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_newsapp_reverpod/view/home_view/news_detalis_view.dart';
import 'package:get/get.dart';

import '../../search.dart';
import '../../view_model/news_view_model/news_state.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(newsProvider.notifier).fetchNews();
    });

    // "ref" can be used in all life-cycles of a StatefulWidget.
  }

  @override
  Widget build(BuildContext context) {
    // We can also use "ref" to listen to a provider inside the build method
    final state = ref.watch(newsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("News"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchUser());
              },
              icon: Icon(
                Icons.search,
                size: 30,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(newsProvider.notifier).fetchNews();
        },
        child: Icon(Icons.add),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          if (state is InitialNewsState) {
            return Text("Press Fab");
          }
          if (state is NewsLoadingNewsState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ErrorNewsState) {
            return Text(state.message);
          }
          if (state is NewsLoadedNewsState) {
            return ListView.builder(
                itemCount: state.banner.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetalisView(news: state.banner[index],)));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0, right: 4),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    state.banner[index].urlToImage.toString(),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.20,
                                        child: Text(
                                          "Title :",
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.45,
                                        child: Text(
                                          state.banner[index].title.toString(),
                                          maxLines: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.20,
                                        child: Text(
                                          "Description :",
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.45,
                                        child: Text(
                                          state.banner[index].description
                                              .toString(),
                                          maxLines: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }

          return const Text("Nothing");
        },
      ),
    );
  }
}

// ListTile(
// leading: CircleAvatar(
// backgroundImage: NetworkImage(state.banner[index].urlToImage.toString()),
//
// ),
// title: Text(state.banner[index].title.toString(),maxLines: 2,),
// subtitle: Text(state.banner[index].description.toString(),maxLines: 4,),
// );
