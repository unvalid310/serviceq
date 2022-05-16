import 'package:flutter/material.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/routes.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/screens/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:serviceq/di_container.dart' as di;

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  SharedPreferences sharedPreferences = di.sl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/welcome-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xFF43AFF8).withOpacity(0.75),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome to ServiceQ',
                  style: TextStyle(
                    fontSize: 20,
                    color: ColorResources.COLOR_WHITE,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  sharedPreferences.getString(AppConstants.USERNAME),
                  style: aladinBold.copyWith(
                    fontSize: 30,
                    color: ColorResources.COLOR_WHITE,
                  ),
                ),
                SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(pageIndex: 0),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFF0094F9),
                    ),
                    child: Text(
                      'CONTINUE',
                      style: aladinBold.copyWith(
                        fontSize: 15,
                        color: ColorResources.COLOR_WHITE,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
