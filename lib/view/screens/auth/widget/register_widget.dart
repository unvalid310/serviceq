import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serviceq/provider/auth_provider.dart';
import 'package:serviceq/utill/color_resources.dart';
import 'package:serviceq/utill/styles.dart';
import 'package:serviceq/view/base/custom_snackbar.dart';
import 'package:serviceq/view/base/custom_text_field.dart';

class RegisterWidget extends StatefulWidget {
  final TabController tabController;
  RegisterWidget({Key key, @required this.tabController}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: aladinRegular.copyWith(
                        fontSize: 15,
                        color: ColorResources.COLOR_WHITE,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Username',
                      inputType: TextInputType.text,
                      controller: _usernameController,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email',
                      style: aladinRegular.copyWith(
                        fontSize: 15,
                        color: ColorResources.COLOR_WHITE,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Email',
                      inputType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Password',
                      style: aladinRegular.copyWith(
                        fontSize: 15,
                        color: ColorResources.COLOR_WHITE,
                      ),
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Password',
                      isPassword: true,
                      isShowSuffixIcon: true,
                      controller: _passwordController,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .registration(
                    _emailController.text,
                    _usernameController.text,
                    _passwordController.text,
                    1,
                  )
                      .then((value) {
                    showCustomSnackBar(value.message, context,
                        isError: !value.isSuccess);
                    if (value.isSuccess) {
                      setState(() {
                        widget.tabController.index = 0;
                      });
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF0094F9),
                  ),
                  child: Text(
                    'REGISTER',
                    style: aladinBold.copyWith(
                      fontSize: 15,
                      color: ColorResources.COLOR_WHITE,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
