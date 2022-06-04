import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/data/model/response/favorit_model.dart';
import 'package:serviceq/provider/favorit_provider.dart';
import 'package:serviceq/provider/lokasi_provider.dart';
import 'package:serviceq/provider/sparepart_provider.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/routes.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/base/custom_login_field.dart';
import 'package:serviceq/view/base/custom_snackbar.dart';

class FilteringScreen extends StatefulWidget {
  FilteringScreen({Key key}) : super(key: key);

  @override
  State<FilteringScreen> createState() => _FilteringScreenState();
}

class _FilteringScreenState extends State<FilteringScreen> {
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _sparepartController = TextEditingController();
  FavoritModel data;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _lokasiController.dispose();
    _sparepartController.dispose();
    super.dispose();
  }

  void _loadData() async {
    // melakukan inisialisasi data favorit user
    await Provider.of<FavoritProvider>(context, listen: false).getFavorit();
    var data = Provider.of<FavoritProvider>(context, listen: false).favoritList;

    if (data != null) {
      data as FavoritModel;
      _lokasiController..text = data.lokasi;
      _sparepartController..text = data.sparepart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritProvider>(
      builder: (context, favoritProvider, child) {
        return LoadingOverlay(
          isLoading: favoritProvider.isLoading,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: _globalKey,
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/detail-bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        CustomLoginField(
                          hintText: 'Lokasi',
                          readOnly: true,
                          controller: _lokasiController,
                          isShowSuffixIcon: true,
                          isIcon: true,
                          suffixIcon: Icons.arrow_drop_down,
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                Provider.of<LokasiProvider>(context,
                                        listen: false)
                                    .getLokasi();
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Consumer<LokasiProvider>(
                                    builder: (context, lokasiProvider, child) {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) =>
                                            Divider(),
                                        itemCount: (lokasiProvider.isLoading)
                                            ? 1
                                            : lokasiProvider.lokasiList.length,
                                        itemBuilder: (context, index) {
                                          return (lokasiProvider.isLoading)
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    setState(
                                                      () {
                                                        _lokasiController.text =
                                                            lokasiProvider
                                                                .lokasiList[
                                                                    index]
                                                                .lokasi;
                                                      },
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    lokasiProvider
                                                        .lokasiList[index]
                                                        .lokasi,
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
                        SizedBox(height: 10),
                        Text(
                          'Wich one you prefer',
                          textAlign: TextAlign.left,
                          style: aladinMedium.copyWith(
                            fontSize: 20,
                            color: ColorResources.COLOR_WHITE,
                          ),
                        ),
                        SizedBox(height: 10),
                        CustomLoginField(
                          hintText: 'Sparepart',
                          readOnly: true,
                          controller: _sparepartController,
                          isShowSuffixIcon: true,
                          isIcon: true,
                          suffixIcon: Icons.arrow_drop_down,
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                Provider.of<SparepartProvider>(context,
                                        listen: false)
                                    .getSparepart();
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Consumer<SparepartProvider>(
                                    builder:
                                        (context, sparepartProvider, child) {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        separatorBuilder: (context, index) =>
                                            Divider(),
                                        itemCount: (sparepartProvider.isLoading)
                                            ? 1
                                            : sparepartProvider
                                                .sparepartList.length,
                                        itemBuilder: (context, index) {
                                          return (sparepartProvider.isLoading)
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    setState(
                                                      () {
                                                        _sparepartController
                                                                .text =
                                                            sparepartProvider
                                                                .sparepartList[
                                                                    index]
                                                                .sparepart;
                                                      },
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    sparepartProvider
                                                        .sparepartList[index]
                                                        .sparepart,
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
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () async {
                      // inisialisasi data yang aka dikirim
                      await Provider.of<FavoritProvider>(context, listen: false)
                          .postFavorit(
                        lokasi: _lokasiController.text,
                        sparepart: _sparepartController.text,
                      )
                          .then(
                        (value) {
                          if (!value.isSuccess) {
                            return showCustomSnackBar(value.message, context);
                          } else {
                            showCustomSnackBar(value.message, context,
                                isError: false);
                          }
                        },
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Update',
                        style: aladinBold.copyWith(
                          fontSize: 15,
                          color: ColorResources.COLOR_WHITE,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      // inisialisasi data yang aka dikirim
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.getDashboardRoute('Rekomendasi'),
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFF0094F9),
                      ),
                      child: Text(
                        'Filtering',
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
        );
      },
    );
  }
}
