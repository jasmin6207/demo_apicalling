import 'package:flutter/material.dart';

import 'Utils.dart';
import 'loginpage.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  String id = "";
  String name = "";
  String email = "";
  String contact = "";
  String  password = "";
  String imagepath = "";
  String imageurl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  getData(){
    id = Utils.prefs!.getString('id') ?? "";
    name = Utils.prefs!.getString('name') ?? "";
    email = Utils.prefs!.getString('email') ?? "";
    contact = Utils.prefs!.getString('contact') ?? "";
    password = Utils.prefs!.getString('password') ?? "";
    imagepath = Utils.prefs!.getString('imagepath') ?? "";
    imageurl = "https://jassmechlions.000webhostapp.com/Jass/profile/";

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homepage")),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text("${name}"), accountEmail: Text("${email}"),
            currentAccountPicture: Image.network(imageurl),
            otherAccountsPictures:[
              Image.network(imageurl),
              Image.network(imageurl)
            ],
            ),
            ListTile(
              title: Text("Add Product"),
              onTap: (){

              },
            ),
            ListTile(
              title: Text("View Product"),
              onTap: (){
                
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: (){
                Utils.prefs!.clear();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return loginpage();
                },
                ));
                },
            ),
            

          ],
        ),
      ),
    );
  }
}
