import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/view/db.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtnumber = TextEditingController();
  TextEditingController txtaddress = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  dbClient dbc = dbClient();

  void getData() async {
    homeController.cList.value = await dbc.readData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Customer"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: txtname,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                hintText: "Enter Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: txtnumber,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone_rounded),
                  hintText: "Enter Mobile No.",
                  border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: txtaddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.article_outlined),
                  hintText: "Enter Adderss",
                  border: OutlineInputBorder()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("cancel")),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    dbc.insertData(
                        txtname.text, txtnumber.text, txtaddress.text);
                    getData();
                    Get.back();
                  },
                  child: const Text("submit"))
            ],
          )
        ],
      ),
    ));
  }
}
