import 'package:flutter/material.dart';
import 'package:kasir_online/provider/user_provider.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';
import 'package:kasir_online/theme/theme.dart';
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
                            "Daftar Akun",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const Text("Daftarkan Akun Anda"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InputSignup(
                            title: "Nama",
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: nameCtrl,
                                  style: theme.textTheme.headline3,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Silahkan Isi nama"),
                                ),
                              ),
                            ],
                          ),
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
                          ),
                          InputSignup(
                            title: "Konfirmasi Kata Sandi",
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passConfirmCtrl,
                                  style: theme.textTheme.headline3,
                                  obscureText: isObsecure,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          "Silahkan Isi Konfirmasi Password"),
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
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signIn');
                              },
                              child: Text(
                                "Masuk Disini",
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
                            // userProvider.signUp(
                            //   context,
                            //   nameCtrl.text,
                            //   emailCtrl.text,
                            //   passCtrl.text,
                            //   passConfirmCtrl.text,
                            // );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboarScreen()));
                          },
                          child: Text(
                            "Daftar",
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
      margin: const EdgeInsets.symmetric(vertical: 10),
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
