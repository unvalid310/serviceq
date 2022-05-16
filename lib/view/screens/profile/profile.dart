import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/di_container.dart' as di;
import 'package:serviceq/provider/auth_provider.dart';
import 'package:serviceq/provider/ulasan_provider.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/screens/auth/login_screen_email.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  final SharedPreferences sharedPreferences = di.sl();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadData() async {
    // melakukan inisialisasi data favorit user
    Provider.of<UlasanProvider>(context, listen: false).getUlasanList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/detail-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Consumer<UlasanProvider>(
        builder: (context, ulasanProvider, child) {
          return LoadingOverlay(
            isLoading: ulasanProvider.isLoading,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              key: _globalKey,
              body: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/image/header.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF73C3F9),
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              sharedPreferences
                                  .getString(AppConstants.USERNAME),
                              style: aladinMedium.copyWith(
                                fontSize: 30,
                                color: Color(0xFFA4DAFF),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              sharedPreferences.getString(AppConstants.EMAIL),
                              style: aladinMedium.copyWith(
                                fontSize: 15,
                                color: Color(0xFFA4DAFF),
                              ),
                            ),
                            SizedBox(height: 15),
                            InkWell(
                              onTap: () async {
                                await Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .logout()
                                    .then(
                                  (value) {
                                    if (value) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreenEmail(),
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  },
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF0094F9),
                                ),
                                child: Text(
                                  'LOGOUT',
                                  style: aladinBold.copyWith(
                                    fontSize: 20,
                                    color: ColorResources.COLOR_WHITE,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Ulasan',
                              style: aladinMedium.copyWith(
                                fontSize: 30,
                                color: Color(0xFFA4DAFF),
                              ),
                            ),
                            SizedBox(height: 20),
                            (!ulasanProvider.isLoading)
                                ? (ulasanProvider.ulasanList != null)
                                    ? ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 15),
                                        itemCount:
                                            ulasanProvider.ulasanList.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                          bottom: 30,
                                          top: 15,
                                        ),
                                        itemBuilder: (context, index) {
                                          var inputDate = DateTime.parse(
                                                  ulasanProvider
                                                      .ulasanList[index]
                                                      .createdAt)
                                              .toLocal();
                                          var outputFormat =
                                              DateFormat('dd-mm-yyyy');
                                          var outputDate =
                                              outputFormat.format(inputDate);

                                          return Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Color(0xFF73C3F9),
                                                width: 5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xFF73C3F9),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        ulasanProvider
                                                            .ulasanList[index]
                                                            .username,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: aladinMedium
                                                            .copyWith(
                                                          color:
                                                              Color(0xFF73C3F9),
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        outputDate,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: aladinMedium
                                                            .copyWith(
                                                          color:
                                                              Color(0xFF73C3F9),
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Container(
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF73C3F9),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: Text(
                                                          ulasanProvider
                                                              .ulasanList[index]
                                                              .ulasan
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: aladinRegular
                                                              .copyWith(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                    : Center(
                                        child: Text(
                                          'Tidak ada ulasan untuk ditampilkan',
                                          style: aladinMedium.copyWith(
                                            fontSize: 20,
                                            color: Color(0xFF73C3F9),
                                          ),
                                        ),
                                      )
                                : Container(),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
