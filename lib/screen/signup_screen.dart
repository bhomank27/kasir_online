import 'package:flutter/material.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/provider/user_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObsecure = true;
  bool isObsecure2 = true;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController passConfirmCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: Image.asset(
                    "assets/bg.png",
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.1,
                      vertical: SizeConfig.screenHeight! * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Daftar Akun",
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal! * 2,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Daftarkan Akun Anda Sekarang",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InputSignup(
                            title: "Nama",
                            children: [
                              SizedBox(
                                width: SizeConfig.screenWidth! * 0.015,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: nameCtrl,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal! *
                                              1.5),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.screenHeight! * 0.027),
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Silahkan Isi nama",
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                1.5,
                                      )),
                                ),
                              ),
                            ],
                          ),
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
                                          SizeConfig.safeBlockHorizontal! *
                                              1.5),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.screenHeight! * 0.027),
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Silahkan Isi Email",
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                1.5,
                                      )),
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
                                          SizeConfig.safeBlockHorizontal! *
                                              1.5),
                                  obscureText: isObsecure,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.screenHeight! * 0.03),
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText:
                                          "Silahkan Isi Password 8+ Karakter",
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                1.5,
                                      )),
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
                                  size: SizeConfig.safeBlockHorizontal! * 2,
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth! * 0.015,
                              ),
                            ],
                          ),
                          InputSignup(
                            title: "Konfirmasi Kata Sandi",
                            children: [
                              SizedBox(
                                width: SizeConfig.screenWidth! * 0.015,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: passConfirmCtrl,
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal! * 1.5,
                                  ),
                                  obscureText: isObsecure2,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.screenHeight! * 0.03),
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText:
                                          "Silahkan Isi Konfirmasi Password",
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! *
                                                1.5,
                                      )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isObsecure2 = !isObsecure2;
                                  });
                                },
                                child: Icon(
                                    isObsecure2
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
                            "Sudah punya Akun ? ",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signIn');
                              },
                              child: Text(
                                "Masuk Disini",
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
                            userProvider.signUp(
                              context,
                              nameCtrl.text,
                              emailCtrl.text,
                              passCtrl.text,
                              passConfirmCtrl.text,
                            );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => DashboarScreen()));
                          },
                          child: Text("Daftar",
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                              ))),
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
