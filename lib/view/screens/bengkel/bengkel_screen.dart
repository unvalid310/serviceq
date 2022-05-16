import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/data/model/response/bengkel_model.dart';
import 'package:serviceq/provider/history_provider.dart';
import 'package:serviceq/provider/rating_provider.dart';
import 'package:serviceq/provider/ulasan_provider.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/base/custom_snackbar.dart';
import 'package:serviceq/view/base/custom_text_field.dart';
import 'package:intl/intl.dart';

class BengkelScreen extends StatefulWidget {
  final BengkelModel bengkelModel;
  final bool rekomendasi;
  BengkelScreen(
      {Key key, @required this.bengkelModel, this.rekomendasi = false})
      : super(key: key);

  @override
  State<BengkelScreen> createState() => _BengkelScreenState();
}

class _BengkelScreenState extends State<BengkelScreen> {
  TextEditingController _ulasanController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _ulasanController.dispose();
    super.dispose();
  }

  void preloadData() async {
    await Provider.of<RatingProvider>(context, listen: false).init();
    await Provider.of<UlasanProvider>(context, listen: false).init();
    await Provider.of<HistoryProvider>(context, listen: false).addHistory(
      widget.bengkelModel.id.toString(),
      widget.bengkelModel.rekomendasi,
    );
  }

  @override
  Widget build(BuildContext context) {
    preloadData();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/detail-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: double.infinity,
            child: Column(
              children: [
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
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 90,
                              backgroundImage: NetworkImage(
                                widget.bengkelModel.foto,
                              ),
                              backgroundColor: ColorResources.COLOR_WHITE,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              widget.bengkelModel.nama,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: aladinMedium.copyWith(
                                fontSize: 30,
                                color: Color(0xFFA4DAFF),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            widget.bengkelModel.deskripsi,
                            overflow: TextOverflow.ellipsis,
                            style: aladinRegular.copyWith(
                              fontSize: 20,
                              color: Color(0xFFA4DAFF),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.place,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.bengkelModel.alamat,
                                overflow: TextOverflow.ellipsis,
                                style: aladinRegular.copyWith(
                                  fontSize: 20,
                                  color: Color(0xFFA4DAFF),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.bengkelModel.jamBuka,
                                overflow: TextOverflow.ellipsis,
                                style: aladinRegular.copyWith(
                                  fontSize: 20,
                                  color: Color(0xFFA4DAFF),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 20,
                                color: Colors.red,
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.bengkelModel.noTelp,
                                overflow: TextOverflow.ellipsis,
                                style: aladinRegular.copyWith(
                                  fontSize: 20,
                                  color: Color(0xFFA4DAFF),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          (widget.rekomendasi)
                              ? (widget.bengkelModel.ulasan.isNotEmpty)
                                  ? Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            'Rating',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: aladinMedium.copyWith(
                                              fontSize: 30,
                                              color: Color(0xFFA4DAFF),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        RatingBar.builder(
                                          initialRating:
                                              widget.bengkelModel.rating,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          unratedColor: Colors.grey,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.red,
                                          ),
                                          ignoreGestures: true,
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            'Ulasan',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: aladinMedium.copyWith(
                                              fontSize: 30,
                                              color: Color(0xFFA4DAFF),
                                            ),
                                          ),
                                        ),
                                        ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 15),
                                          itemCount:
                                              widget.bengkelModel.ulasan.length,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(
                                            bottom: 30,
                                            top: 15,
                                          ),
                                          itemBuilder: (context, index) {
                                            var inputDate = DateTime.parse(
                                                    widget
                                                        .bengkelModel
                                                        .ulasan[index]
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
                                                          widget
                                                              .bengkelModel
                                                              .ulasan[index]
                                                              .username,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: aladinMedium
                                                              .copyWith(
                                                            color: Color(
                                                                0xFF73C3F9),
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
                                                            color: Color(
                                                                0xFF73C3F9),
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF73C3F9),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                          child: Text(
                                                            widget
                                                                .bengkelModel
                                                                .ulasan[index]
                                                                .ulasan
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: aladinRegular
                                                                .copyWith(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white,
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
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          child: Text(
                                            'Rating',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: aladinMedium.copyWith(
                                              fontSize: 30,
                                              color: Color(0xFFA4DAFF),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        RatingBar.builder(
                                          initialRating:
                                              widget.bengkelModel.rating,
                                          minRating: 0,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          unratedColor: Colors.grey,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.red,
                                          ),
                                          ignoreGestures: true,
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        SizedBox(height: 30),
                                      ],
                                    )
                              : Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        child: Text(
                                          'Ulasan',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: aladinMedium.copyWith(
                                            fontSize: 30,
                                            color: Color(0xFFA4DAFF),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Consumer<UlasanProvider>(
                                        builder:
                                            (context, ulasanProvider, child) {
                                          _isLoading = ulasanProvider.isLoading;

                                          return CustomTextField(
                                            hintText: 'Tulis ulasan disini',
                                            inputType: TextInputType.text,
                                            controller: _ulasanController,
                                            maxLines: 5,
                                          );
                                        },
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        child: Text(
                                          'Give Rating',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: aladinMedium.copyWith(
                                            fontSize: 30,
                                            color: Color(0xFFA4DAFF),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Consumer<RatingProvider>(
                                        builder:
                                            (context, ratingProvider, child) {
                                          _isLoading = ratingProvider.isLoading;

                                          return RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            unratedColor: Colors.grey,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.red,
                                            ),
                                            onRatingUpdate: (rating) async {
                                              print(rating);
                                              await Provider.of<RatingProvider>(
                                                context,
                                                listen: false,
                                              )
                                                  .postRating(
                                                    widget.bengkelModel.id,
                                                    rating,
                                                  )
                                                  .then(
                                                    (value) =>
                                                        showCustomSnackBar(
                                                      value.message,
                                                      context,
                                                      isError: !value.isSuccess,
                                                    ),
                                                  );
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(height: 30),
                                      InkWell(
                                        onTap: () async {
                                          await Provider.of<UlasanProvider>(
                                                  context,
                                                  listen: false)
                                              .postUlasan(
                                                widget.bengkelModel.id,
                                                _ulasanController.text,
                                              )
                                              .then(
                                                (value) => showCustomSnackBar(
                                                  value.message,
                                                  context,
                                                  isError: !value.isSuccess,
                                                ),
                                              );
                                          _ulasanController.clear();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 25),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0xFF0094F9),
                                          ),
                                          child: Text(
                                            'SUBMIT',
                                            style: aladinBold.copyWith(
                                              fontSize: 15,
                                              color: ColorResources.COLOR_WHITE,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                    ],
                                  ),
                                ),
                        ],
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
