import 'dart:convert';
import 'package:loginscreen_sharedprefs/Resources/UrlResource.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class forgetpass extends StatefulWidget {
  

  @override
  State<forgetpass> createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {

//shop total system
  // alldata
  // total = 0;
  // alldata loop
  // {
  //   total = total + (qty *price);
//}


bool selected=false;

  TextEditingController _emil = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("forgetpassword"),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text("Entre your emil//phone no"),
              SizedBox(height: 10,),
              TextField(
                controller: _emil,

                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10,),
              Switch(value: selected, onChanged: (val){
                //switch button

                if(val==true)
                  {

                  }
                else
                  {

                  }

                setState(() {
                  selected=val;
                });
              }),
              Center(
                child: ElevatedButton(
                  onPressed: ()async{

                    var email = _emil.text.toString();
                    Map<String,String> params = {
                      "email": email,
                    };

                    Map<String,String> header = {
                      "Content-Type":"application/json",
                    };

                    Uri url = Uri.parse(UrlResource.FORGET);
                    var response = await http.post(url,body: jsonEncode(params));
                    if(response.statusCode==200)
                    {
                      print(response.body);
                      var json = jsonDecode(response.body);
                      if(json["result"]=="success")
                      {
                        var message = json["message"];


                      }
                    }


                  },

                  child: Text("submit"),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
