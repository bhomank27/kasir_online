import 'package:flutter/material.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/provider/user_provider.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
import 'package:kasir_online/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: SizeConfig.screenHeight!,
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/bg2.png",
                        fit: BoxFit.fill,
                      ),
                      Image.asset(
                        "assets/bg.png",
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Daftar Akun",
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal! * 4,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Daftarkan Akun Anda",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal! * 2,
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
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: nameCtrl,
                                  style: theme.textTheme.headline3,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Silahkan Isi nama",
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! * 2,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          InputSignup(
                            title: "Email",
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: emailCtrl,
                                  style: theme.textTheme.headline3,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Silahkan Isi Email",
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! * 2,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          InputSignup(
                            title: "Kata Sandi",
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: passCtrl,
                                  style: theme.textTheme.headline3,
                                  obscureText: isObsecure,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Silahkan Isi Password 8+ Karakter",
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! * 2,
                                      )),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObsecure = !isObsecure;
                                    });
                                  },
                                  icon: Icon(isObsecure
                                      ? Icons.visibility
                                      : Icons.visibility_off))
                            ],
                          ),
                          InputSignup(
                            title: "Konfirmasi Kata Sandi",
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: passConfirmCtrl,
                                  style: theme.textTheme.headline3,
                                  obscureText: isObsecure2,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Silahkan Isi Konfirmasi Password",
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal! * 2,
                                      )),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObsecure2 = !isObsecure2;
                                    });
                                  },
                                  icon: Icon(isObsecure2
                                      ? Icons.visibility
                                      : Icons.visibility_off))
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
                              fontSize: SizeConfig.safeBlockHorizontal! * 2,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signIn');
                              },
                              child: Text(
                                "Masuk Disini",
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal! * 2,
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
                                fontSize: SizeConfig.safeBlockHorizontal! * 2,
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal! * 2,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
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
