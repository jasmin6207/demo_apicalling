import 'package:demo_apicalling/Utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';
import 'loginpage.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gonext();
  }

  gonext()

  async {

    Utils.prefs = await SharedPreferences.getInstance();

    await Future.delayed(Duration(seconds: 2));

    bool loginstatus = Utils.prefs!.getBool('loginstatus') ?? false;

    if(loginstatus)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return homepage();
      },));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return loginpage();
      },));
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
