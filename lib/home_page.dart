import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tambal_ban/helper/api.dart';
import 'package:flutter_tambal_ban/register.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _bengkel = [];

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambal Ban"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const RegisterPage());
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              getLocation();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: _bengkel),
        ),
      ),
    );
  }

  void getLocation() async {
    EasyLoading.show();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    EasyLoading.dismiss();
    getBengkel(position.latitude, position.longitude);
  }

  void getBengkel(double lat, double lon) {
    Api.postData(context, "https://tambal.agungj.com/bengkel/cari",
        {"latitude": lat, "longitude": lon, "type": "all"}).then((value) {
      _bengkel.clear();
      for (int i = 0; i < value!.data!.length; i++) {
        _bengkel.add(
          InkWell(
            onTap: () {
              showDetail(value.data);
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 15,
              child: Row(
                children: [
                  Flexible(
                    child: Image.network(
                        "https://tambal.agungj.com/source/photo/${value.data![i]['picture']}"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              value.data![i]['nama_bengkel'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Table(
                            border: const TableBorder(
                                horizontalInside: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.black)),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            columnWidths: const <int, TableColumnWidth>{
                              0: FractionColumnWidth(0.3),
                              1: FractionColumnWidth(0.05),
                              2: FractionColumnWidth(0.65),
                            },
                            children: [
                              TableRow(children: [
                                const Text("Alamat"),
                                const Text(":"),
                                Text(value.data![i]['alamat'],
                                    textAlign: TextAlign.end),
                              ]),
                              TableRow(children: [
                                const Text("Phone"),
                                const Text(":"),
                                Text(value.data![i]['phone'],
                                    textAlign: TextAlign.end),
                              ]),
                              TableRow(children: [
                                const Text("Operasional"),
                                const Text(":"),
                                Text(
                                    "${value.data![i]['jam_buka']}:00 s/d ${value.data![i]['jam_tutup']}:00",
                                    textAlign: TextAlign.end),
                              ]),
                              TableRow(children: [
                                const Text("Motor"),
                                const Text(":"),
                                Text(
                                  value.data![i]['motor'],
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: value.data![i]['motor'] == "TERSEDIA"
                                        ? Colors.green[900]
                                        : Colors.red[900],
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                const Text("Mobil"),
                                const Text(":"),
                                Text(
                                  value.data![i]['mobil'],
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: value.data![i]['mobil'] == "TERSEDIA"
                                        ? Colors.green[900]
                                        : Colors.red[900],
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                const Text("Jarak"),
                                const Text(":"),
                                Text(
                                  "${value.data![i]['jarak']} Km",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: value.data![i]['jarak'] < 2.0
                                        ? Colors.green[900]
                                        : Colors.red[900],
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      setState(() {});
    });
  }

  void showDetail(List? data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            data![0]['nama_bengkel'],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Table(
              border: const TableBorder(
                  horizontalInside: BorderSide(
                      width: 1, style: BorderStyle.solid, color: Colors.black)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const <int, TableColumnWidth>{
                0: FractionColumnWidth(0.3),
                1: FractionColumnWidth(0.05),
                2: FractionColumnWidth(0.65),
              },
              children: [
                TableRow(children: [
                  const Text("Alamat"),
                  const Text(":"),
                  Text(data[0]['alamat'], textAlign: TextAlign.end),
                ]),
                TableRow(children: [
                  const Text("Phone"),
                  const Text(":"),
                  Text(data[0]['phone'], textAlign: TextAlign.end),
                ]),
                TableRow(children: [
                  const Text("Operasional"),
                  const Text(":"),
                  Text(
                      "${data[0]['jam_buka']}:00 s/d ${data[0]['jam_tutup']}:00",
                      textAlign: TextAlign.end),
                ]),
                TableRow(children: [
                  const Text("Motor"),
                  const Text(":"),
                  Text(
                    data[0]['motor'],
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: data[0]['motor'] == "TERSEDIA"
                          ? Colors.green[900]
                          : Colors.red[900],
                    ),
                  ),
                ]),
                TableRow(children: [
                  const Text("Mobil"),
                  const Text(":"),
                  Text(
                    data[0]['mobil'],
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: data[0]['mobil'] == "TERSEDIA"
                          ? Colors.green[900]
                          : Colors.red[900],
                    ),
                  ),
                ]),
                TableRow(children: [
                  const Text("Jarak"),
                  const Text(":"),
                  Text(
                    "${data[0]['jarak']} Km",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: data[0]['jarak'] < 2.0
                          ? Colors.green[900]
                          : Colors.red[900],
                    ),
                  ),
                ]),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              String googleMapsUrl =
                  "https://www.google.com/maps/search/?api=1&query=${data[0]['latitude']},${data[0]['longitude']}";
              Get.back();
              bukaBrowser(googleMapsUrl);
            },
            child: const Text("Open Map"),
          ),
        ],
      ),
    );
  }

  Future<void> bukaBrowser(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}
