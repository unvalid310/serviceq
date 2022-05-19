import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/provider/bengkel_provider.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/screens/bengkel/bengkel_screen.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // membuat fungsi memanggil data bengkel
  void loadData() async {
    await Provider.of<BengkelProvider>(context, listen: false).getBengekList();
  }

  @override
  Widget build(BuildContext context) {
    // memanggil fungsi untuk menampilkan data bengkel
    loadData();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/auth-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Consumer<BengkelProvider>(
        builder: (context, bengkelProvider, child) {
          // preloading sebelum data ditampilkan
          return LoadingOverlay(
            isLoading: bengkelProvider.isLoading,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              key: _globalKey,
              body: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            "assets/image/header.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: (!bengkelProvider.isLoading)
                          ? (bengkelProvider.bengkelList.isNotEmpty)
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0,
                                      20,
                                      0,
                                      MediaQuery.of(context).size.height *
                                          10 /
                                          100),
                                  // menampilkan data bengkel
                                  child: ListView.builder(
                                    itemCount:
                                        bengkelProvider.bengkelList.length,
                                    padding: EdgeInsets.only(top: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          // navigasi untuk menampilkan detail bengkel
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BengkelScreen(
                                                bengkelModel: bengkelProvider
                                                    .bengkelList[index],
                                                rekomendasi: bengkelProvider
                                                    .bengkelList[index]
                                                    .rekomendasi,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              10, 0, 10, 10),
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF43AFF8)
                                                .withOpacity(0.75),
                                            borderRadius:
                                                BorderRadius.circular(45),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 35,
                                                backgroundImage: NetworkImage(
                                                  bengkelProvider
                                                      .bengkelList[index].foto,
                                                ),
                                                backgroundColor:
                                                    ColorResources.COLOR_WHITE,
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    bengkelProvider
                                                        .bengkelList[index]
                                                        .nama,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        aladinMedium.copyWith(
                                                      fontSize: 20.sp,
                                                      color: ColorResources
                                                          .COLOR_WHITE,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              // menampilkan pesan error ketika data tidak ada
                              : Center(
                                  child: Text(
                                    'Tidak ada data untuk ditampilkan',
                                    style: aladinMedium.copyWith(
                                      fontSize: 20,
                                      color: Color(0xFF73C3F9),
                                    ),
                                  ),
                                )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
