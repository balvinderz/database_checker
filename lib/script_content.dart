import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ScriptContent extends StatefulWidget
{
  final String url;
  ScriptContent(this.url);

  @override
  _ScriptContentState createState() => _ScriptContentState();
}

class _ScriptContentState extends State<ScriptContent> {
  bool exiting = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          exiting = true;

        });
        return true;

      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("File contents"),
        ),
        body: exiting ? Container() : FutureBuilder(
          future: get(Uri.parse(widget.url)),

          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
          Response data = snapshot.data;
        String fileContent = data.body;
        fileContent =  fileContent.split('\n').reversed.join("\n");

            return SingleChildScrollView(child: Text(fileContent));
          }
        ),
      ),
    );
  }
}