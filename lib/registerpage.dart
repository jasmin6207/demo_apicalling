
import 'dart:io';
import 'dart:convert';
import 'package:demo_apicalling/loginpage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  TextEditingController tname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController tpassword = TextEditingController();


  ImagePicker _picker = ImagePicker();
  String imagepath = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          InkWell(onTap: () async {

            final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

            setState(() {
              imagepath = photo!.path;
            });

          },
        child: Container(
          height: 80,
          width: 80,
          child: imagepath.isEmpty
          ?Icon(Icons.supervised_user_circle)
          : Image.file(File(imagepath)),
        ),
          ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tname,
                decoration: InputDecoration(hintText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: temail,
                decoration: InputDecoration(hintText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tcontact,
                decoration: InputDecoration(hintText: "Contact"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tpassword,
                decoration: InputDecoration(hintText: "Password"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  String name = tname.text;
                  String email = temail.text;
                  String contact = tcontact.text;
                  String password = tpassword.text;

                  waitDialog();
                  String api =
                      "https://jassmechlions.000webhostapp.com/Jass/register.php";

                  DateTime dt = DateTime.now();
                  String imagename = "$name${dt.year}${dt.month}${dt.day}${dt.hour}${dt.minute}${dt.second}.jpg";

                  var formData = FormData.fromMap({
                    'name': name,
                    'email': email,
                    'contact' : contact,
                    'password' : password,
                    'file': await MultipartFile.fromFile(imagepath, filename: imagename),

                  });
                  var response = await Dio().post(api, data: formData);

                  Navigator.pop(context);
    if(response.statusCode==200) {
      print("Response : ${response.data}");

      Map map = jsonDecode(response.data);

      int result = map['result'];

      if (result == 0) {
        print("Try again");
      }
      else if (result == 1) {


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
          return loginpage();
        },));
      }
      else if (result==2)
        {
          SimpleDialog(children: [Text("User already Exist"),], alignment: Alignment.center,);
          print("user Already Exist");
        }
    }
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }

  waitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Container(
              height: 60,
              child: ListTile(
                leading: Container(
                    height: 50, width: 50, child: CircularProgressIndicator()),
                title: Text("Please Wait......"),
              ),
            )
          ],
        );
      },
    );
  }
}
