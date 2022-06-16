import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginscreen_sharedprefs/model/Userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewScreen extends StatefulWidget {


  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {



  Userdata mainobj;
  getdata() async
  {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    var json = jsonDecode(prefs.getString("Userdata"));
    Userdata obj = Userdata.fromJson(json);
    setState(() {
      mainobj=obj;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
    //  body: (mainobj==nul?l)?CircularProgressIndicator():Text(mainobj.name)
      body:
      //(mainobj==null)?
      (mainobj!=null)?
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(mainobj.name.toString()),
               Text(mainobj.email.toString())
            ],
          ),
        ),
      )
            :Center(child: CircularProgressIndicator(),)

    );
  }
}
