import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/provider/auth_provider.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/screens/auth/widget/login_widget.dart';
import 'package:serviceq/view/screens/auth/widget/register_widget.dart';
import 'package:sizer/sizer.dart';

class LoginScreenEmail extends StatefulWidget {
  @override
  _LoginScreenEmailState createState() => _LoginScreenEmailState();
}

class _LoginScreenEmailState extends State<LoginScreenEmail>
    with TickerProviderStateMixin {
  //create controller untuk tabBar
  TabController controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = new TabController(
      vsync: this,
      length: 2,
    );
    controller.addListener(() {
      if (controller.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });

    Provider.of<AuthProvider>(context, listen: false)
        .clearRegistrationErrorMessage();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/auth-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: LoadingOverlay(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      child: Image.asset(
                        'assets/image/logo.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Color(0xFF43AFF8).withOpacity(0.75),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: TabBar(
                              controller: controller,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white,
                              isScrollable: false,
                              labelStyle: aladinMedium.copyWith(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      (_selectedIndex == 0) ? 20 : 0),
                                  topRight: Radius.circular(
                                      (_selectedIndex == 0) ? 0 : 20),
                                ),
                                color: Color(0xFF0094F9),
                              ),
                              tabs: const <Widget>[
                                Tab(
                                  text: "LOGIN",
                                ),
                                Tab(
                                  text: "REGISTER",
                                ),
                              ],
                              onTap: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.53,
                            child: TabBarView(
                              controller: controller,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                LoginWidget(tabController: controller),
                                RegisterWidget(tabController: controller)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                color: ColorResources.COLOR_GREY,
                isLoading: false, //authProvider.isLoading,
                progressIndicator: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  strokeWidth: 1.h,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
