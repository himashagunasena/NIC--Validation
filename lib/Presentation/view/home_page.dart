import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nic_validation/Presentation/view/common/button.dart';
import 'package:nic_validation/Presentation/view/nic_validation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),backgroundColor: Colors.pink,),
      body: CommonButton(onTap: () {  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NicValidation())); }, name: 'next',),
    );
  }
}