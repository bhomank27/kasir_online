import 'package:flutter/material.dart';
import 'package:kasir_online/theme/theme.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:kasir_online/widget/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../widget/drawer_main.dart';

class DashboarScreen extends StatefulWidget {
  const DashboarScreen({super.key});

  @override
  State<DashboarScreen> createState() => _DashboarScreenState();
}

class _DashboarScreenState extends State<DashboarScreen> {
  bool isVisible = false;
  DateTime? today;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  dateFormat(DateTime date) {
    return DateFormat("dd-MM-yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = Theme.of(context).textTheme;
    return Scaffold(
      appBar: appbarWidget(),
      drawer: const DrawerMain(),
      body: Stack(children: [
        Container(
          color: Colors.red,
          height: size.height / 5,
          width: size.width,
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavbarMain(size: size, style: style),
                const subNavbar(),
                contentMain(context),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Row contentMain(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    Text("Kalender Penjualan", style: TextStyle(fontSize: 20)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: TableCalendar(
                    onDaySelected: _onDaySelected,
                    selectedDayPredicate: ((day) {
                      isVisible = false;
                      return isSameDay(day, today);
                    }),
                    onHeaderTapped: ((_) {
                      setState(() {
                        today = DateTime.now();
                      });
                    }),
                    locale: "id",
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    availableGestures: AvailableGestures.all,
                    focusedDay: today ?? DateTime.now(),
                    firstDay: DateTime.utc(2010, 01, 01),
                    lastDay: DateTime.utc(2030, 12, 30),
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: !isVisible,
          child: Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hasil Penjualan ${dateFormat(today!)}",
                        style: TextStyle(fontSize: 20)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = true;
                          });
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              Column(
                  children: List.generate(
                      2,
                      (index) => const SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  "Rp.12.000",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ))),
            ],
          )),
        )
      ],
    );
  }
}

class NavbarMain extends StatelessWidget {
  const NavbarMain({
    Key? key,
    required this.size,
    required this.style,
  }) : super(key: key);

  final Size size;
  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon/transaksi.png",
                height: 50,
              ),
              Text("Transaksi Baru", style: style.headline2)
            ],
          ),
        ),
      ),
    );
  }
}

class subNavbar extends StatelessWidget {
  const subNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        ButtonDashboard(
          title: "Retur Penjualan",
          icon: "retur_penjualan.png",
        ),
        ButtonDashboard(
          title: "Stok Barang",
          icon: "stok_barang.png",
        ),
        ButtonDashboard(
          title: "Laporan",
          icon: "laporan.png",
        ),
        ButtonDashboard(
          title: "Retur Penjualan",
          icon: "retur_penjualan.png",
        ),
        ButtonDashboard(
          title: "Retur Penjualan",
          icon: "retur_penjualan.png",
        ),
      ],
    );
  }
}

class ButtonDashboard extends StatelessWidget {
  final String? title;
  final String? icon;
  const ButtonDashboard({super.key, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return Expanded(
      child: GestureDetector(
        onTap: (() {
          print("button aktif");
        }),
        child: SizedBox(
          width: 250,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/$icon",
                    height: 50,
                  ),
                  Text(title!, style: style.headline2)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
