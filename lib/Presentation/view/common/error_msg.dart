import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showAlert(BuildContext context,String message){
  Widget okbutton = FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("ok"));
  AlertDialog alert =AlertDialog(
    content: Text(message) ,
    actions: [okbutton],
  );
  showDialog(context: context, builder:(BuildContext context){
    return alert;
  });
}