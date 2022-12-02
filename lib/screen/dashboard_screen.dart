import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kasir_online/helper/layout.dart';
import 'package:kasir_online/provider/user_provider.dart';
import 'package:kasir_online/screen/dataTransaksi_screen.dart';
import 'package:kasir_online/screen/product_screen.dart';
import 'package:kasir_online/screen/retur_penjualan_screen.dart';
import 'package:kasir_online/screen/stok_screen.dart';
import 'package:kasir_online/screen/transaksi_screen.dart';
import 'package:kasir_online/theme/theme.dart';
import 'package:kasir_online/widget/appbar_main.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../extention/datetime.dart';
import '../widget/drawer_main.dart';

class DashboarScreen extends StatefulWidget {
  const DashboarScreen({super.key});

  @override
  State<DashboarScreen> createState() => _DashboarScreenState();
}

class _DashboarScreenState extends State<DashboarScreen>
    with TickerProviderStateMixin {
  DateTime? today;
  ScrollController scrollController = ScrollController();
  var namaCtrl = TextEditingController();
  var alamatCtrl = TextEditingController();
  var telpCtrl = TextEditingController();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;
    var style = Theme.of(context).textTheme;
    SizeConfig().init(context);

    return Scaffold(
      appBar: appbarWidget(context: context),
      drawer: const DrawerMain(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Stack(children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: SizeConfig.screenHeight! * 0.34,
                width: size.width,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TransaksiScreen()))),
                        child: NavbarMain(size: size, style: style)),
                    const subNavbar(),
                    contentMain(context),
                  ],
                ),
              )
            ]),
          ),
          FutureBuilder(
            future: userProvider.getProfile(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Visibility(
                    // jika pendatang baru visible di aktifkan
                    visible: false,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Container(
                          width: double.infinity,
                          height: SizeConfig.screenHeight,
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal! * 3,
                          ),
                          color: Colors.black.withOpacity(0.7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon/profile.png',
                                height: SizeConfig.screenHeight! * 0.2,
                                fit: BoxFit.cover,
                              ),
                              Text("Buat Toko Dulu Yuk!",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal! * 3,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              InputToko(
                                controller: namaCtrl,
                                title: "Masukkan Nama Toko",
                              ),
                              InputToko(
                                controller: alamatCtrl,
                                title: "Masukkanalamat Toko",
                              ),
                              InputToko(
                                controller: telpCtrl,
                                title: "Masukkan Telepon",
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.blockSizeHorizontal! * 2,
                                        vertical:
                                            SizeConfig.blockSizeVertical! *
                                                1.5)),
                                onPressed: () {
                                  print("buat toko berhasil");
                                },
                                child: Text("Buat toko",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal! *
                                                2)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              } else {
                return Visibility(visible: false, child: Container());
              }
            },
          ),
        ],
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
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Kalender Penjualan",
                  style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal! * 2,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: TableCalendar(
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color:
                              (Theme.of(context).primaryColor).withOpacity(0.6),
                          shape: BoxShape.circle)),
                  onDaySelected: _onDaySelected,
                  selectedDayPredicate: ((day) {
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
                          fontSize: SizeConfig.safeBlockHorizontal! * 2,
                          fontWeight: FontWeight.bold)),
                  availableGestures: AvailableGestures.all,
                  focusedDay: today ?? DateTime.now(),
                  firstDay: DateTime.utc(2010, 01, 01),
                  lastDay: DateTime.utc(2030, 12, 30),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hasil Penjualan ",
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal! * 2),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "${dateToMonth(DateTime.now())}",
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Rp.12.000",
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal! * 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text("${dateFormat(today ?? DateTime.now())}"),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Rp.12.000",
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal! * 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ))
      ],
    );
  }
}

class InputToko extends StatelessWidget {
  var controller;
  var title;
  InputToko({this.controller, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal! * 2),
      margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical! * 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: SizeConfig.screenWidth! * 0.4,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: title,
            hintStyle:
                TextStyle(fontSize: SizeConfig.blockSizeHorizontal! * 2)),
      ),
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
    SizeConfig().init(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Container(
        // height: size.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 5),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icon/transaksi.png",
                  height: SizeConfig.safeBlockHorizontal! * 4,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1,
                ),
                Text("Transaksi Baru",
                    style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor))
              ],
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
    SizeConfig().init(context);
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, mainAxisExtent: SizeConfig.screenHeight! * 0.2),
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
    SizeConfig().init(context);
    var style = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: ontap ?? () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon/$icon",
                height: SizeConfig.safeBlockHorizontal! * 4,
                // height: 50,
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 1,
              ),
              Text(
                title!,
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal! * 1.5,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
