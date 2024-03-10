import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tambal_ban/helper/api.dart';
import 'package:flutter_tambal_ban/home_page.dart';
import 'package:flutter_tambal_ban/style/style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _title = "Daftarkan Bengkel";
  bool _isUpdate = false;

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _konfirmasi = TextEditingController();
  final TextEditingController _nama_bengkel = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _jam_buka = TextEditingController();
  final TextEditingController _jam_tutup = TextEditingController();
  final TextEditingController _tubles_motor = TextEditingController();
  final TextEditingController _non_tubles_motor = TextEditingController();
  final TextEditingController _tubles_mobil = TextEditingController();
  final TextEditingController _tiptop_mobil = TextEditingController();
  final TextEditingController _latitude = TextEditingController();
  final TextEditingController _longitude = TextEditingController();

  File? _picture;

  @override
  void initState() {
    super.initState();
    getLocation();
    if (Get.arguments != null) {
      _title = "Bengkel Anda";
      _isUpdate = true;
      _username.text = Get.arguments[0]['username'].toString();
      _password.text = Get.arguments[0]['password'].toString();
      _konfirmasi.text = Get.arguments[0]['konfirmasi'].toString();
      _nama_bengkel.text = Get.arguments[0]['nama_bengkel'].toString();
      _alamat.text = Get.arguments[0]['alamat'].toString();
      _phone.text = Get.arguments[0]['phone'].toString();
      _jam_buka.text = Get.arguments[0]['jam_buka'].toString();
      _jam_tutup.text = Get.arguments[0]['jam_tutup'].toString();
      _tubles_motor.text = Get.arguments[0]['tubles_motor'].toString();
      _non_tubles_motor.text = Get.arguments[0]['non_tubles_motor'].toString();
      _tubles_mobil.text = Get.arguments[0]['tubles_mobil'].toString();
      _tiptop_mobil.text = Get.arguments[0]['tiptop_mobil'].toString();
      _latitude.text = Get.arguments[0]['latitude'].toString();
      _longitude.text = Get.arguments[0]['longitude'].toString();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: [
          Visibility(
            visible: _isUpdate,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Center(
                      child: Text("Hapus Bengkel?"),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text("Batal"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Api.postData(
                              context,
                              "https://tambal.agungj.com/bengkel/delete",
                              {"username": _username.text}).then((value) {
                            Get.offAll(() => const HomePage());
                          });
                        },
                        child: const Text("Hapus"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !_isUpdate,
                child: Column(
                  children: [
                    TextField(
                      controller: _username,
                      decoration: Style().dekorasiInput(
                        hint: "Username",
                        icon: const Icon(
                          Icons.person,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: Style().dekorasiInput(
                        hint: "Password",
                        icon: const Icon(
                          Icons.vpn_key,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _konfirmasi,
                      obscureText: true,
                      decoration: Style().dekorasiInput(
                        hint: "Konfirmasi Password",
                        icon: const Icon(
                          Icons.vpn_key,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              TextField(
                controller: _nama_bengkel,
                decoration: Style().dekorasiInput(
                  hint: "Nama Bengkel",
                  icon: const Icon(
                    Icons.numbers,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _alamat,
                decoration: Style().dekorasiInput(
                  hint: "Alamat",
                  icon: const Icon(
                    Icons.numbers,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _phone,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: Style().dekorasiInput(
                  hint: "Phone",
                  icon: const Icon(
                    Icons.phone,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _jam_buka,
                readOnly: true,
                onTap: () => showDialogJam('buka'),
                decoration: Style().dekorasiInput(
                  hint: "Jam Buka",
                  icon: const Icon(
                    Icons.lock_clock,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _jam_tutup,
                readOnly: true,
                onTap: () => showDialogJam('tutup'),
                decoration: Style().dekorasiInput(
                  hint: "Jam Tutup",
                  icon: const Icon(
                    Icons.lock_clock,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _tubles_motor,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: Style().dekorasiInput(
                  hint: "Tubles Motor",
                  icon: const Icon(
                    Icons.tire_repair,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _non_tubles_motor,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: Style().dekorasiInput(
                  hint: "Non Tubles Motor",
                  icon: const Icon(
                    Icons.tire_repair,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _tubles_mobil,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: Style().dekorasiInput(
                  hint: "Tubles Mobil",
                  icon: const Icon(
                    Icons.tire_repair,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _tiptop_mobil,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: Style().dekorasiInput(
                  hint: "Tiptop Mobil",
                  icon: const Icon(
                    Icons.tire_repair,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _latitude,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))
                ],
                decoration: Style().dekorasiInput(
                  hint: "Latitude",
                  icon: const Icon(
                    Icons.pin_drop,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: _longitude,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+.?[0-9]*'))
                ],
                decoration: Style().dekorasiInput(
                  hint: "Longitude",
                  icon: const Icon(
                    Icons.pin_drop,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Center(
                        child: Text("Pilih Sumber"),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              Get.back();
                              getPicture(ImageSource.gallery);
                            },
                            child: const Text("Get From Galery"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Get.back();
                              getPicture(ImageSource.camera);
                            },
                            child: const Text("Get From Camera"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    (_picture == null
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 40,
                            ),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(_picture!),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )),
                    const Text("Foto Bengkel"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_username.text.isEmpty ||
              _password.text.isEmpty ||
              _konfirmasi.text.isEmpty ||
              _nama_bengkel.text.isEmpty ||
              _alamat.text.isEmpty ||
              _phone.text.isEmpty ||
              _jam_buka.text.isEmpty ||
              _jam_tutup.text.isEmpty ||
              _latitude.text.isEmpty ||
              _longitude.text.isEmpty) {
            Get.snackbar("Maaf", "Harap Lengkapi Data Anda");
          } else {
            if (!_isUpdate && _picture == null) {
              Get.snackbar("Maaf", "Foto Anda Kosong");
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Center(
                    child: Text("Simpan Data Ini?"),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Batal"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        simpanData();
                      },
                      child: const Text("Simpan"),
                    ),
                  ],
                ),
              );
            }
          }
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.save),
      ),
    );
  }

  showDialogJam(var oc) {
    showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
    ).then((value) {
      if (value != null) {
        if (oc == 'buka') {
          _jam_buka.text = "${value.hour}:00";
        } else {
          _jam_tutup.text = "${value.hour}:00";
        }
      }
    });
  }

  Future<void> getPicture(ImageSource source) async {
    await ImagePicker()
        .pickImage(source: source, imageQuality: 10)
        .then((value) {
      if (value!.path.isNotEmpty) {
        _picture = File(value.path);
        setState(() {});
      }
    }).catchError((err) {});
  }

  void getLocation() async {
    EasyLoading.show();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    _latitude.text = "${position.latitude}";
    _longitude.text = "${position.longitude}";
    EasyLoading.dismiss();
  }

  void simpanData() async {
    dio.FormData formData = dio.FormData.fromMap({
      "is_update": _isUpdate ? 1 : 0,
      "username": _username.text,
      "password": _password.text,
      "nama_bengkel": _nama_bengkel.text,
      "alamat": _alamat.text,
      "phone": _phone.text,
      "jam_buka": _jam_buka.text.replaceAll(":00", ""),
      "jam_tutup": _jam_tutup.text.replaceAll(":00", ""),
      "tubles_motor": _tubles_motor.text,
      "non_tubles_motor": _non_tubles_motor.text,
      "tubles_mobil": _tubles_mobil.text,
      "tiptop_mobil": _tiptop_mobil.text,
      "latitude": _latitude.text,
      "longitude": _longitude.text,
      "picture": (_picture == null
          ? null
          : await dio.MultipartFile.fromFile(
              _picture!.path,
              filename: "picture.jpg",
            ))
    });
    Api.postDataMultiPart(
            context, "https://tambal.agungj.com/bengkel/register", formData)
        .then((value) {
      if (value!.status == "success") {
        Get.offAll(() => const HomePage());
      }
    });
  }
}
