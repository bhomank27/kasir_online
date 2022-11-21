import 'package:flutter/material.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/calendar.dart';
import 'package:kasir_online/widget/drawer_main.dart';

class ReturPenjualanScreen extends StatefulWidget {
  const ReturPenjualanScreen({Key? key}) : super(key: key);

  @override
  State<ReturPenjualanScreen> createState() => _ReturPenjualanScreenState();
}

class _ReturPenjualanScreenState extends State<ReturPenjualanScreen> {
  bool isVisibile = false;
  bool isShowCalendar = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbarWidget(title: "Retur Penjualan"),
      drawer: const DrawerMain(),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20)),
                            onPressed: () {
                              setState(() {
                                isVisibile = true;
                              });
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.add_circle),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text("Tambah Data",
                                    style:
                                        Theme.of(context).textTheme.headline2)
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DataTable(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        columns: [
                          DataColumn(
                              label: Text(
                            "Tanggal",
                            style: Theme.of(context).textTheme.headline1,
                          )),
                          DataColumn(
                              label: Text("Penjualan",
                                  style:
                                      Theme.of(context).textTheme.headline1)),
                          DataColumn(
                              label: Text("Retur Penjualan",
                                  style:
                                      Theme.of(context).textTheme.headline1)),
                          DataColumn(
                              label: Text("Total Penjualan",
                                  style:
                                      Theme.of(context).textTheme.headline1)),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text("31 OKT 2022",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.black))),
                            DataCell(Text("Rp 10.000",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.black))),
                            DataCell(Text("Rp 2.000",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.black))),
                            DataCell(Text("Rp 8.000",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.black))),
                          ]),
                        ])
                  ],
                ),
              ),
              Visibility(
                visible: isVisibile,
                child: Container(
                  height: size.height / 1.3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            blurRadius: 5,
                            color: Colors.grey[400]!)
                      ]),
                  margin: const EdgeInsets.all(50),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisibile = false;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 40,
                              )),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "Tanggal",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  SizedBox(width: 200, child: TextFormField())
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "Penjualan",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  SizedBox(width: 200, child: TextFormField())
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "Retur Penjualan",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  SizedBox(width: 200, child: TextFormField())
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      "Total Pendapatan",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  SizedBox(width: 200, child: TextFormField())
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 10)),
                                  onPressed: () {
                                    setState(() {
                                      isVisibile = false;
                                    });
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.save),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Simpan ")
                                    ],
                                  ))
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isShowCalendar = !isShowCalendar;
                                });
                              },
                              icon: const Icon(
                                Icons.calendar_month,
                                color: Colors.red,
                                size: 50,
                              )),
                          Visibility(
                              visible: isShowCalendar,
                              child: const Expanded(child: CalendarWidget()))
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
