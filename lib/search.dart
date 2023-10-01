
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_task_newsapp_reverpod/view_model/news_view_model/news_state.dart';


class SearchUser extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = "";

      }, icon: Icon(Icons.close, size: 20,))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back_ios, size: 20,));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(newsProvider);
        if (state is InitialNewsState) {
          return Text("Press Fab");
        }
        if (state is NewsLoadingNewsState) {
          return CircularProgressIndicator();
        }
        if (state is ErrorNewsState) {
          return Text(state.message);
        }
        if (state is NewsLoadedNewsState) {
          return ListView.builder(
              itemCount: state.banner.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0,right: 4),
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
                );
              });
        }

        return const Text("Nothing");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search", style: TextStyle(fontSize: 20,color: Colors.black),),
    );
  }

}