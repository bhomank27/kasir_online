import 'package:flutter/material.dart';
import 'package:kasir_online/widget/appbar_main.dart';

class TransaksiScreen extends StatelessWidget {
  const TransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(title: "Transaksi Baru"),
      body: ListView(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.blue,
                  child: const Text("sfkjdsk"),
                )),
            Expanded(
                child: Container(
                    // color: Colors.green,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 20,
                          offset: Offset(-4, -4),
                          color: Color.fromARGB(255, 169, 169, 169))
                    ]),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Keranjang Belanja",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.80,
                          child: ListView.separated(
                            itemCount: 10,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                height: 10,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("Abc kecap",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      Text("1", style: TextStyle(fontSize: 20)),
                                      Text("Rp.12.000",
                                          style: TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text("2.400",
                                          style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Text("Laba : 2.000",
                                          style: TextStyle(fontSize: 20))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RawMaterialButton(
                                        onPressed: () {},
                                        shape: const CircleBorder(),
                                        fillColor: Colors.red,
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                      RawMaterialButton(
                                        onPressed: () {},
                                        shape: const CircleBorder(),
                                        fillColor: Colors.red,
                                        child: const Icon(
                                          Icons.file_copy,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Total",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text("Rp 10.400",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Tunai",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text("Rp 20.000",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Kembali",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  Text("Rp 9.600",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(5)),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.print,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("Cetak", style: TextStyle(fontSize: 20))
                              ],
                            ))
                      ],
                    ))),
          ],
        )
      ]),
    );
  }
}
