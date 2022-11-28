import 'package:flutter/material.dart';
import 'package:kasir_online/provider/user_provider.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
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
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/bg2.png",
                      scale: 1.17,
                    ),
                    Image.asset(
                      "assets/bg.png",
                      scale: 1.17,
                    )
                  ],
                )),
            Expanded(
                flex: 3,
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
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const Text("Silahkan Masukan Akun Anda"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InputSignup(
                            title: "Email",
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: emailCtrl,
                                  style: theme.textTheme.headline3,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Silahkan Isi Email"),
                                ),
                              ),
                            ],
                          ),
                          InputSignup(
                            title: "Kata Sandi",
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passCtrl,
                                  style: theme.textTheme.headline3,
                                  obscureText: isObsecure,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Silahkan Isi Password 8+ Karakter"),
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
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum punya Akun ? ",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (route) => false);
                              },
                              child: Text(
                                "Daftar disini",
                                style: Theme.of(context).textTheme.headline2,
                              ))
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20)),
                          onPressed: () {
                            userProvider.login(
                                context, emailCtrl.text, passCtrl.text);
                          },
                          child: Text(
                            "Masuk",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: Colors.white,
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: Theme.of(context).textTheme.headline1,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 15),
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
