import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:loginscreen_sharedprefs/utility/ApiHandler.dart';
import 'package:loginscreen_sharedprefs/utility/ErrorHandler.dart';

import 'model/RegisterDetails.dart';

class fakeapi extends StatefulWidget {


  @override
  State<fakeapi> createState() => _fakeapiState();
}

class _fakeapiState extends State<fakeapi> {

  List<RegisterDetail> alldata;
  getdata()async{

    try{
      // await ApiHandler.get("https://invicainfotech.com/apicall/mydata").then((json){
      //   setState(() {
      //     alldata = json["contacts"]
      //         .map<RegisterDetail>((obj) => RegisterDetail.fromJson(obj))
      //         .toList();
      //   });
      // });



      Uri url = Uri.parse("https://invicainfotech.com/apicall/mydata");
      var response = await http.get(url);
      if(response.statusCode==200)
        {
          var json = jsonDecode(response.body);
          setState(() {
            alldata = json["contacts"]
                .map<RegisterDetail>((obj) => RegisterDetail.fromJson(obj))
                .toList();
          });
        }

    }
    on ErrorHandler catch (ex)
     {
       if(ex.code.toString()=="500")
         {
           print(Text("NoINterner"));
         }
    }
    
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
      body: (alldata!=null)?
      ListView.builder(
        itemCount: alldata.length,
        itemBuilder: (context,index){
          return Container(
            child: Column(
              children: [
                Text("name"+alldata[index].name.toString()),
                Image.network(alldata[index].userimage.toString()),
                Text(alldata[index].email.toString())
              ],
            ),
          );
        },
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}
