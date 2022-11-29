import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kasir_online/screen/dataTransaksi_screen.dart';
import 'package:kasir_online/screen/product_screen.dart';
import 'package:kasir_online/screen/retur_penjualan_screen.dart';
import 'package:kasir_online/screen/stok_screen.dart';
import 'package:kasir_online/screen/transaction_screen.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../widget/drawer_main.dart';

class DashboarScreen extends StatefulWidget {
  const DashboarScreen({super.key});

  @override
  State<DashboarScreen> createState() => _DashboarScreenState();
}

class _DashboarScreenState extends State<DashboarScreen>
    with TickerProviderStateMixin {
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
    // var appbar = appbarWidget();
    // double heigthQuery = appbar!.preferredSize.height - size.height;

    return Scaffold(
      appBar: appbarWidget(context: context),
      drawer: const DrawerMain(),
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: size.height * 0.4,
            width: size.width,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NavbarMain(size: size, style: style),
                const subNavbar(),
                contentMain(context),
              ],
            ),
          )
        ]),
      ),
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
              FittedBox(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Kalender Penjualan",
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: TableCalendar(
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle),
                        selectedDecoration: BoxDecoration(
                            color: (Theme.of(context).primaryColor)
                                .withOpacity(0.6),
                            shape: BoxShape.circle)),
                    onDaySelected: _onDaySelected,
                    selectedDayPredicate: ((day) {
                      isVisible = true;
                      return isSameDay(day, today);
                    }),
                    calendarBuilders: CalendarBuilders(
                        holidayBuilder: ((context, day, focusedDay) {})),
                    onHeaderTapped: ((_) {
                      setState(() {
                        today = DateTime.now();
                      });
                    }),
                    locale: "id",
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
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
          visible: isVisible,
          child: Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hasil Penjualan ${dateFormat(today ?? DateTime.now())}",
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = false;
                          });
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: ListView.builder(
                    itemBuilder: (context, builder) => const SizedBox(
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Rp.12.000",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
              )
            ],
          )),
        )
      ],
    );
  }
}

class NavbarMain extends StatelessWidget {
  NavbarMain({
    Key? key,
    required this.size,
    required this.style,
  }) : super(key: key);

  var size;
  final TextTheme style;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: GestureDetector(
              onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TransaksiScreen()))),
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/transaksi.png",
                      // height: 50,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text("Transaksi Baru",
                        style: style.headline2!
                            .copyWith(color: Theme.of(context).primaryColor))
                  ],
                ),
              ),
            ),
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
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, mainAxisExtent: 120),
      shrinkWrap: true,
      children: [
        ButtonDashboard(
          title: "Retur Penjualan",
          icon: "retur_penjualan.png",
          ontap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ReturPenjualanScreen())),
        ),
        ButtonDashboard(
          title: "Stok Barang",
          icon: "stok_barang.png",
          ontap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const StokScreen())),
        ),
        ButtonDashboard(
          title: "Laporan",
          icon: "laporan.png",
        ),
        ButtonDashboard(
          title: "Produk",
          icon: "produk.png",
          ontap: () => Navigator.push(context,
              (MaterialPageRoute(builder: (context) => ProdukScreen()))),
        ),
        ButtonDashboard(
          title: "Data Transaksi",
          icon: "data_transaksi.png",
          ontap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => DataTransaksiScreen())),
        ),
      ],
    );
  }
}

class ButtonDashboard extends StatelessWidget {
  final String? title;
  final String? icon;
  void Function()? ontap;
  ButtonDashboard({super.key, this.title, this.icon, this.ontap});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: ontap ?? () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icon/$icon",
                  color: Theme.of(context).primaryColor,
                  // height: 50,
                ),
                Text(title!,
                    style: style.headline2!
                        .copyWith(color: Theme.of(context).primaryColor))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
