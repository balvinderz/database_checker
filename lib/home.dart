import 'dart:math';
import 'dart:convert' as json;
import 'package:databasecheckerapp/database_card.dart';
import 'package:databasecheckerapp/post.dart';
import 'package:databasecheckerapp/scripts_screen.dart';
import 'package:flutter/material.dart';
import 'package:incrementally_loading_listview/incrementally_loading_listview.dart';
import 'package:http/http.dart' as http;

import 'notifications/firebase_notification_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String baseUrl =
      "http://pyadmin.season-life.co.uk/api/jobs/?format=json&page=";
  bool _loadingMore = false;

  final key = GlobalKey<ScaffoldState>();
  bool hasMoreItems = true;
  int index = 1;
  List<Post> posts = [];
  String time = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(icon : Icon(Icons.description),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ScriptsScreen()));

            },),
          )
        ],
        title: Text("Admin app"),

      ),
      body: RefreshIndicator(
        onRefresh: _reload,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(time),
              IncrementallyLoadingListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                hasMore: () => hasMoreItems,
                itemCount: () => posts.length,
                loadMore: () async {
                  if (_loadingMore) {
                    index += 1;
                    await    getPage(baseUrl + "$index");
                  }
                },
                onLoadMore: () {
                  setState(() {
                    _loadingMore = true;
                  });
                },
                onLoadMoreFinished: () {
                  setState(() {
                    _loadingMore = false;
                  });
                },
                itemBuilder: (context, index) {
                  if(_loadingMore && index == posts.length-1)
                    return  Center(child: CircularProgressIndicator());

                  return DatabaseCard(posts[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();

    FirebaseNotifications(context).setUpFirebase();

    getPage(baseUrl + "$index");
  }

  getPage(String url) async {
    var response = await http.get(url);

    await getPosts(response.body);
  }

  void getPosts(String response) async  {
    var j = json.jsonDecode(response);
    // print(j['results']);


    if (j['next'] == null) hasMoreItems = false;

    for (var i = 0; i < j['results'].length; i++) {
      var result = j['results'][i];
      Post post = Post.fromJson(result);
      //print(post.id);
      posts.add(post);
    }
    setState(() {});
  }



  Future<void> _reload() async
  {


    setState(() {
      index=1;
      posts =[];



    });
    await getPage(baseUrl+"$index");
    return ;

  }
}
