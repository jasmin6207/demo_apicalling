import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  TextEditingController tusername = TextEditingController();
  TextEditingController tpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Login"),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tusername,
            ),),
            Padding(padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: tpassword,
            ),),
            ElevatedButton(onPressed: () async {

              String username = tusername.text;
              String password = tpassword.text;

              waitDialog();

              String api = 'https://jassmechlions.000webhostapp.com/Jass/login.php?username=$username&password=$password';

              var response = await Dio().get(api);
              print(response);

              if(response.statusCode==200)
                {
                  Map map = jsonDecode(response.data);

                  int result = map['result'];

                  if(result == 0)
                    {
                      print("Invalid Username or Password");
                    }
                  else
                    {
                      Map data = map['data'];

                      String id = data['id'];
                      String name = data['name'];
                      String email = data['email'];
                      String contact = data['contact'];
                      String password = data['password'];
                      String imagepath = data['imagepath'];
                    }
                }

            }, child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  waitDialog() {
    showDialog(context: context, builder: (context){
      return SimpleDialog(
        children: [
          Container(
            height:  60,
            child: ListTile(
              leading:  Container(
                height: 50, width: 50,child: CircularProgressIndicator()),
            ),
          )
        ],
      );
    },
    );
  }
}
