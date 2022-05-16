import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/di_container.dart' as di;
import 'package:serviceq/provider/filter_provider.dart';
import 'package:serviceq/provider/rekomendasi_provider.dart';
import 'package:serviceq/provider/tipe_bengkel_provider.dart';
import 'package:serviceq/utill/app_constants.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/screens/bengkel/bengkel_screen.dart';
import 'package:serviceq/view/screens/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class RekomendasiScreen extends StatefulWidget {
  @override
  _RekomendasiScreenState createState() => _RekomendasiScreenState();
}

class _RekomendasiScreenState extends State<RekomendasiScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  SharedPreferences sharedPreferences = di.sl();

  @override
  void initState() {
    super.initState();
  }

  void loadData() async {
    await Provider.of<RekomendasiProvider>(context, listen: false)
        .getRekomendasiList();
    await Provider.of<FilterProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/auth-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Consumer<RekomendasiProvider>(
        builder: (context, rekomendasiProvider, child) {
          return LoadingOverlay(
            isLoading: rekomendasiProvider.isLoading,
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
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Consumer<FilterProvider>(
                                  builder: (context, filterProvider, child) {
                                    return Text(
                                      filterProvider.filter ?? '',
                                      style: aladinRegular.copyWith(
                                        fontSize: 25,
                                        color: Color(0xFF73C3F9),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF73C3F9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Icons.ballot_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                onTap: () async {
                                  await showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      Provider.of<TipeBengkelProvider>(context,
                                              listen: false)
                                          .getTipeBengkel();
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Consumer<TipeBengkelProvider>(
                                          builder: (context,
                                              tipeBengkelProvider, child) {
                                            return (tipeBengkelProvider
                                                    .isLoading)
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          ColorResources
                                                              .PRIMARY_COLOR,
                                                    ),
                                                  )
                                                : ListView.separated(
                                                    shrinkWrap: true,
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            Divider(),
                                                    itemCount: (tipeBengkelProvider
                                                            .isLoading)
                                                        ? tipeBengkelProvider
                                                                .tipeBengkelList
                                                                .length +
                                                            1
                                                        : tipeBengkelProvider
                                                            .tipeBengkelList
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          await Provider.of<
                                                                      FilterProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addFilter(
                                                            tipeBengkelProvider
                                                                .tipeBengkelList[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                          )
                                                              .then((value) {
                                                            if (value
                                                                .isSuccess) {
                                                              Navigator
                                                                  .pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DashboardScreen(
                                                                    pageIndex:
                                                                        1,
                                                                  ),
                                                                ),
                                                                (router) =>
                                                                    false,
                                                              );
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          tipeBengkelProvider
                                                              .tipeBengkelList[
                                                                  index]
                                                              .tipe,
                                                          style: aladinMedium
                                                              .copyWith(
                                                            fontSize: 10.sp,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: (!rekomendasiProvider.isLoading)
                          ? (rekomendasiProvider.bengkelList.isNotEmpty)
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
                                        rekomendasiProvider.bengkelList.length,
                                    padding: EdgeInsets.only(top: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BengkelScreen(
                                                bengkelModel:
                                                    rekomendasiProvider
                                                        .bengkelList[index],
                                                rekomendasi: rekomendasiProvider
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
                                                  rekomendasiProvider
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
                                                    rekomendasiProvider
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
                                              Text(
                                                rekomendasiProvider
                                                    .bengkelList[index].rating
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: aladinRegular.copyWith(
                                                  fontSize: 15.sp,
                                                  color: ColorResources
                                                      .COLOR_WHITE,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Icon(
                                                Icons.star,
                                                color:
                                                    ColorResources.COLOR_WHITE,
                                                size: 35,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'Tidak ada rekomendasi untuk ditampilkan',
                                    style: aladinMedium.copyWith(
                                      fontSize: 20,
                                      color: Color(0xFF73C3F9),
                                    ),
                                  ),
                                )
                          : Container(),
                    )
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
