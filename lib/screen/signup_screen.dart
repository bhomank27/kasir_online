import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/bg2.png',
                    ),
                    Image.asset('assets/bg.png'),
                  ],
                )),
            Expanded(
                flex: 3,
                child: Container(
                  color: Colors.green,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Daftar",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          const Text("Daftarkan akun anda")
                        ],
                      ),
                      InputSignup(
                        title: "Nama",
                        hint: "e.x Admin",
                      ),
                      InputSignup(
                        title: "Nama",
                        hint: "e.x Admin",
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class InputSignup extends StatelessWidget {
  String? title;
  String? hint;
  InputSignup({Key? key, this.title, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Theme.of(context).textTheme.headline1,
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "e.x : Admin"),
          ),
        )
      ],
    );
  }
}
