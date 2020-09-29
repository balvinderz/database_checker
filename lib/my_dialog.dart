import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget
{
  final String title;
 final  Function onYesClick;
  MyDialog(this.title,this.onYesClick);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:   Center(child: Text(title,textAlign: TextAlign.center,)) ,
      content: Row(
        children: [
          Expanded(
            
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),

              ),
              color: Colors.blue,
              child: Text("Yes"),
              onPressed: onYesClick,
            ),
          ),
          SizedBox
            (
            width: 10,
          ),
          Expanded(
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),

              ),
              color: Colors.blue,
              child: Text("No"),
              onPressed: (){Navigator.pop(context);},
            ),
          ),
        ],
      ),
    );

  }
}