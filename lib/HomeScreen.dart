import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen_sharedprefs/RegisterScreen.dart';
import 'package:loginscreen_sharedprefs/Resources/UrlResource.dart';
import 'package:loginscreen_sharedprefs/forgetpass.dart';
import 'package:http/http.dart' as http;
import 'package:loginscreen_sharedprefs/model/Userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewScreen.dart';

class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

TextEditingController _name = TextEditingController();
TextEditingController _password = TextEditingController();


cheklogoin()async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  if(prefs.containsKey("name"))
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>ViewScreen())
      );
    }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _name.text="dipak";
    // _password.text="123456";
  cheklogoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("LoginScreen"),),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Text("Name"),
              SizedBox(height: 10,),
              TextField(
                controller: _name,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),
              Text("password"),
              TextField(
                controller: _password,

                keyboardType: TextInputType.number,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: ()async{

                    var name = _name.text.toString();
                    var pass = _password.text.toString();

                    Map<String, String>parms={
                      "name": name,
                      "password": pass,
                      "device_token":"12345678",
                      "device_os":"android"
                    };
                    var heder = {
                      "Content-Type":"application/json"
                    };

                    Uri url = Uri.parse(UrlResource.LOGIN);
                    var response = await http.post(url,body: jsonEncode(parms),headers: heder);
                    if(response.statusCode==200)
                      {
                        var json =jsonDecode(response.body);
                        if(json["result"]=="success")
                          {
                            Fluttertoast.showToast(
                                msg: "Successfully Login",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            SharedPreferences prefs= await SharedPreferences.getInstance();

                            prefs.setString("name", name);
                            //Userdata obj = Userdata.fromJson();
                            prefs.setString("Userdata",jsonEncode(json["data"]));

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>ViewScreen())
                            );
                          }
                        else{
                          Fluttertoast.showToast(
                              msg: "Somthing Wrong",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }

                  },
                  child: Text("Login"),
                ),
              ),
              SizedBox(height: 20,),

             TextButton(
                 onPressed: ()async{
                   
                   Navigator.of(context).push(
                     MaterialPageRoute(builder: (context)=>forgetpass())
                   );

                 },


                 child:Text("Forget password")),


             Container(
               margin: EdgeInsets.only(left: 50),
               child:  TextButton(onPressed: ()async{
                 
                 Navigator.of(context).push(
                   MaterialPageRoute(builder: (context)=>RegisterScreen())
                 );

               },
                   child:Row(
                     children: [
                       Text("you have account?"),
                       Text("registeraccount",style: TextStyle(color: Colors.red),)
                     ],
                   )
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}
