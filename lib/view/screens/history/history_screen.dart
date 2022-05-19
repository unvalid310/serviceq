import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/provider/bengkel_provider.dart';
import 'package:serviceq/provider/history_provider.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/screens/bengkel/bengkel_screen.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // membuat fungsi memanggil data history
  void loadData() async {
    await Provider.of<HistoryProvider>(context, listen: false).getHistroyList();
  }

  @override
  Widget build(BuildContext context) {
    // memanggil fungsi untuk menampilkan data history
    loadData();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/auth-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Consumer<HistoryProvider>(
        builder: (context, historyProvider, child) {
          return LoadingOverlay(
            // preloading sebelum data ditampilkan
            isLoading: historyProvider.isLoading,
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
                      child: (!historyProvider.isLoading)
                          // menampilkan data history
                          ? (historyProvider.historyList != null)
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0,
                                      20,
                                      0,
                                      MediaQuery.of(context).size.height *
                                          10 /
                                          100),
                                  child: ListView.builder(
                                    itemCount:
                                        historyProvider.historyList.length,
                                    padding: EdgeInsets.only(top: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          // navigasi untuk menampilkan data history
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BengkelScreen(
                                                bengkelModel: historyProvider
                                                    .historyList[index],
                                                rekomendasi: historyProvider
                                                    .historyList[index]
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
                                                  historyProvider
                                                      .historyList[index].foto,
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
                                                    historyProvider
                                                        .historyList[index]
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
                                              (historyProvider
                                                      .historyList[index]
                                                      .rekomendasi)
                                                  ? Row(
                                                      children: [
                                                        Text(
                                                          historyProvider
                                                              .historyList[
                                                                  index]
                                                              .rating
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: aladinRegular
                                                              .copyWith(
                                                            fontSize: 15.sp,
                                                            color: ColorResources
                                                                .COLOR_WHITE,
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Icon(
                                                          Icons.star,
                                                          color: ColorResources
                                                              .COLOR_WHITE,
                                                          size: 35,
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                                    'Tidak ada history unutuk ditampilkan',
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
