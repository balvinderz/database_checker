import 'package:databasecheckerapp/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class DatabaseCard extends StatefulWidget {
  final Post post;

  DatabaseCard(this.post);

  @override
  _DatabaseCardState createState() => _DatabaseCardState();
}

class _DatabaseCardState extends State<DatabaseCard> {
  bool verified = false;

  @override
  Widget build(BuildContext context) {
    return verified
        ? Container()
        : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(widget.post.message),
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: approvePost,
                      color: Colors.lightBlueAccent,
                      child: Text("Approve"),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: MaterialButton(
                      onPressed: disapprovePost,
                      color: Colors.red,
                      child: Text("Remove"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void approvePost() async {
    String url =
        "http://pyadmin.season-life.co.uk/api/jobss/approve/${widget.post.id}";
    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode != 200) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Error occured"),
        ));
        return;
      } else {
        setState(() {
          verified = true;
        });
        showDialog(context: context,builder: (_)=> AlertDialog(content : Text(response.body),));

      }
    }
    catch(e)
    {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Error occured")));
    }
  }
  void disapprovePost() async {
    String url =
        "http://pyadmin.season-life.co.uk/api/jobss/disapprove/${widget.post.id}";
    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode != 200) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Error occured"),
        ));
        return;
      } else {
        setState(() {
          verified = true;
        });
        showDialog(context: context,builder: (_)=> AlertDialog(content : Text(response.body),));
      }
    }catch(e)
    {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Error occured")));

    }
  }

}

