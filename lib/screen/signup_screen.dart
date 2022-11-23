import 'package:flutter/material.dart';
import 'package:kasir_online/screen/dashboard_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            hint: "Masukkan Nama Lengkap",
                          ),
                          InputSignup(
                            title: "Email",
                            hint: "Masukkan Alamat Email",
                          ),
                          InputSignup(
                            title: "Kata Sandi",
                            hint: "Masukkan Kata sandi",
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
                              onPressed: () {},
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DashboarScreen()));
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
  String? title;
  String? hint;
  bool? obsecure;
  InputSignup({Key? key, this.title, this.hint, this.obsecure})
      : super(key: key);

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
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: TextFormField(
                    obscureText: obsecure ?? false,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: hint),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye))
              ],
            ),
          )
        ],
      ),
    );
  }
}
