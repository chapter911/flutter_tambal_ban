import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tambal_ban/style/style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _konfirmasi = TextEditingController();
  final TextEditingController _nama_bengkel = TextEditingController();
  final TextEditingController _alamat = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _picture = TextEditingController();
  final TextEditingController _jam_buka = TextEditingController();
  final TextEditingController _jam_tutup = TextEditingController();
  final TextEditingController _tubles_motor = TextEditingController();
  final TextEditingController _non_tubles_motor = TextEditingController();
  final TextEditingController _tubles_mobil = TextEditingController();
  final TextEditingController _tiptop_mobil = TextEditingController();
  final TextEditingController _latitude = TextEditingController();
  final TextEditingController _longitude = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftarkan Bengkel"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                controller: _picture,
                decoration: Style().dekorasiInput(
                  hint: "Picture",
                  icon: const Icon(
                    Icons.image,
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
}
