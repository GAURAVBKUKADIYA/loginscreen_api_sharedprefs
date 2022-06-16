import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen_sharedprefs/HomeScreen.dart';

import 'package:loginscreen_sharedprefs/Resources/UrlResource.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Register"),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name"),
              SizedBox(height: 10,),
              TextField(
                controller: _name,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),
              Text("email"),
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              TextField(
                controller: _email,

                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),
              Text("Password"),
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              TextField(

                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10,),
              Text("ConfirmPAssword"),
              SizedBox(height: 10,),
              TextField(

                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: ()async{

                        Navigator.of(context).pop();


                      }, child:Text("cancle")),

                  SizedBox(width: 20,),

                  ElevatedButton(
                      onPressed: ()async{

                        var name = _name.text.toString();
                        var email = _email.text.toString();
                        var pass = _password.text.toString();
                        var confirmpass = _confirmpassword.text.toString();

                        Map<String,String> params = {
                          "name": name,
                          "email": email,
                          "password":pass,
                          "confirm_password": confirmpass,
                          "device_token":"12345678",
                          "device_os":"android",
                          "version_type":"openness",
                          "group":"2",
                          "version":"1",
                          "time_zone":"IST",
                          "ip_address": "103.232.125.6"
                        };

                        Map<String,String> header = {
                          "Content-Type":"application/json",
                        };
                        
                        Uri url = Uri.parse(UrlResource.REGISTER);
                        var response = await http.post(url,body: jsonEncode(params),headers: header);
                        if(response.statusCode==200)
                          {
                            print(response.body.toString());
                            var json = jsonDecode(response.body);
                            if(json["result"]=="success")
                              {
                                var message = json["message"];
                                Fluttertoast.showToast(
                                    msg: message,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=>HomeScreen())
                                );
                              }
                            else{
                              Fluttertoast.showToast(
                                  msg: "somthingwrong",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          }

                      },

                      child:Text("Register")),

                ],
              )

            ],
          ),
        ),
      ),

    );
  }
}
