import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessView extends StatefulWidget {
  const SuccessView({Key? key}) : super(key: key);

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text("Success View"),backgroundColor: Colors.pink,),
     body: Container(),
   );
  }
}