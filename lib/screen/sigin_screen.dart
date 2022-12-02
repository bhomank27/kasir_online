import 'package:flutter/material.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/provider/user_provider.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
import 'package:kasir_online/screen/signup_screen.dart';
import 'package:kasir_online/theme/theme.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isObsecure = true;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: SizeConfig.screenHeight!,
                  child: Image.asset(
                    "assets/bg.png",
                    fit: BoxFit.cover,
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Masuk Akun",
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal! * 2,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("Silahkan Masukan Akun Anda",
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InputSignup(
                            title: "Email",
                            children: [
                              SizedBox(
                                width: SizeConfig.screenWidth! * 0.015,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: emailCtrl,
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal! * 1.5,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.screenHeight! * 0.03),
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Silahkan Isi Email"),
                                ),
                              ),
                            ],
                          ),
                          InputSignup(
                            title: "Kata Sandi",
                            children: [
                              SizedBox(
                                width: SizeConfig.screenWidth! * 0.015,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: passCtrl,
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal! * 1.5,
                                  ),
                                  obscureText: isObsecure,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.screenHeight! * 0.03),
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText:
                                          "Silahkan Isi Password 8+ Karakter"),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isObsecure = !isObsecure;
                                  });
                                },
                                child: Icon(
                                    isObsecure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    size: SizeConfig.safeBlockHorizontal! * 2),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth! * 0.015,
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum punya Akun ? ",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()),
                                    (route) => false);
                              },
                              child: Text(
                                "Daftar disini",
                                style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal! * 1.5,
                                ),
                              ))
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.blockSizeVertical! * 2)),
                          onPressed: () {
                            userProvider.login(
                                context, emailCtrl.text, passCtrl.text);
                          },
                          child: Text(
                            "Masuk",
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}

class InputSignup extends StatelessWidget {
  TextEditingController? controller;
  String? title;
  List<Widget>? children;
  InputSignup({
    Key? key,
    this.title,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight! * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.015),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children!,
            ),
          )
        ],
      ),
    );
  }
}
