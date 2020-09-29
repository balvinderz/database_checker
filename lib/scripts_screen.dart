import 'package:databasecheckerapp/models/scripts.dart';
import 'package:databasecheckerapp/my_dialog.dart';
import 'package:databasecheckerapp/script_content.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScriptsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("Scripts"),
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
            .reference()
            .child("scripts")
            .onValue,
        builder: (_, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          Scripts scripts = Scripts.fromMap(snapshot.data.snapshot.value);

          return SingleChildScrollView(
            child: Column(
                children: [
            ListTile(
            title: Text("Runner Script"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) =>
                            MyDialog(
                                "Do you want to ${scripts.runnerScript
                                    ? "stop"
                                    : "start"} the runner script?",
                                    () {
                                  FirebaseDatabase.instance
                                      .reference()
                                      .child("scripts")
                                      .update(
                                      {"runner_script": !scripts.runnerScript});
                                  Navigator.pop(_);
                                }));
                  }
                  , icon: scripts.runnerScript
                    ? Icon(
                  Icons.stop,
                  color: Colors.red,
                )
                    : Icon(
                  Icons.play_arrow,
                  color: Colors.green,
                ),
                ),
                IconButton(
                  icon: Icon(Icons.description),
                  onPressed: (){
                    print(scripts.runnerFile);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_)=> ScriptContent(scripts.runnerFile)
                    ));
                  },
                )
              ],
            ),
            ),
            ListTile(
                title: Text("Page Script"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                MyDialog(
                                    "Do you want to ${scripts.pageScript
                                        ? "stop"
                                        : "start"} the page script?",
                                        () {
                                      FirebaseDatabase.instance
                                          .reference()
                                          .child("scripts")
                                          .update(
                                          {"page_script": !scripts.pageScript});
                                      Navigator.pop(_);
                                    }));
                      },
                      icon: scripts.pageScript
                          ? Icon(
                        Icons.stop,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.play_arrow,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.description),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (_)=> ScriptContent(scripts.pageFile)
                        ));
                      },
                    )
                  ],
                )),
            ListTile(
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) =>
                              MyDialog(
                                  "Do you want to ${scripts.groupScript
                                      ? "stop"
                                      : "start"} the group script?",
                                      () {
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child("scripts")
                                        .update(
                                        {"group_script": !scripts.groupScript});
                                    Navigator.pop(_);
                                  }));
                    },
                    icon: scripts.groupScript
                        ? Icon(
                      Icons.stop,
                      color: Colors.red,
                    )
                        : Icon(
                      Icons.play_arrow,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.description),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_)=> ScriptContent(scripts.groupFile)
                      ));
                    },
                  )
                ],
              ),
              title: Text("Group Script"),
            ),
            ListTile(
                title: Text("Insta Script"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                MyDialog(
                                    "Do you want to ${scripts.instaScript
                                        ? "stop"
                                        : "start"} the insta script?",
                                        () {
                                      FirebaseDatabase.instance
                                          .reference()
                                          .child("scripts")
                                          .update({
                                        "insta_script": !scripts.instaScript
                                      });
                                      Navigator.pop(_);
                                    }));
                      },
                      icon: scripts.instaScript
                          ? Icon(
                        Icons.stop,
                        color: Colors.red,
                      )
                          : Icon(
                        Icons.play_arrow,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.description),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (_)=> ScriptContent(scripts.instaFile)
                        ));
                      },
                    )
                  ],
                ))
            ],
          ),);
        },
      ),
    );
  }
}
