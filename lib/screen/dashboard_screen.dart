import 'package:flutter/material.dart';
import 'package:kasir_online/widget/calendar.dart';

class DashboarScreen extends StatefulWidget {
  const DashboarScreen({super.key});

  @override
  State<DashboarScreen> createState() => _DashboarScreenState();
}

class _DashboarScreenState extends State<DashboarScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.help)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Stack(children: [
        Container(
          color: Colors.red,
          height: size.height / 5,
          width: size.width,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
              ),
              Row(
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
              ),
              const Text("Kalender Penjualan"),
              const Expanded(child: Card(child: CalendarWidget())),
            ],
          ),
        )
      ]),
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
    );
  }
}
