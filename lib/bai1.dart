import 'package:flutter/material.dart';

class Managerment extends StatefulWidget {
  const Managerment({super.key});

  @override
  State<Managerment> createState() => _ManagermentState();
}

class NhanVien {
  String masv, hoten, namsinh;
  NhanVien(this.masv, this.hoten, this.namsinh);
}

class _ManagermentState extends State<Managerment> {
  final TextEditingController _maStaffController = TextEditingController();
  final TextEditingController _tenStaffController = TextEditingController();
  final TextEditingController _namSinhStaffController = TextEditingController();
  List<NhanVien> listNhanVien = <NhanVien>[];
  String reset = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Staff Managerment",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "STUDENT INFORMATION",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: _maStaffController,
                decoration: const InputDecoration(
                    labelText: 'Mã Sinh Viên:',
                    labelStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    alignLabelWithHint: true,
                    hoverColor: Colors.blue),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: _tenStaffController,
                decoration: const InputDecoration(
                    labelText: 'Họ và Tên:',
                    labelStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    alignLabelWithHint: true,
                    hoverColor: Colors.blue),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: _namSinhStaffController,
                decoration: const InputDecoration(
                    labelText: 'Năm Sinh:',
                    labelStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    alignLabelWithHint: true,
                    hoverColor: Colors.blue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  setState(() {
                    if (_maStaffController.text.isNotEmpty &&
                        _tenStaffController.text.isNotEmpty &&
                        _namSinhStaffController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StaffContent(
                            masv: _maStaffController.text,
                            tenSv: _tenStaffController.text,
                            namsinh: _namSinhStaffController.text,
                          ),
                        ),
                      );
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: double.infinity,
                  child: const Text(
                    'Gửi thông tin',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaffContent extends StatelessWidget {
  const StaffContent(
      {super.key,
      required this.masv,
      required this.tenSv,
      required this.namsinh});
  final String masv, tenSv, namsinh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('THONG TIN SINH VIEN'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Mã NV',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        masv,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1.0,
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        tenSv,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        namsinh,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
