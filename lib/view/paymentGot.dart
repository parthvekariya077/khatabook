// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/view/db.dart';

class PaymentGot extends StatefulWidget {
  const PaymentGot({Key? key}) : super(key: key);

  @override
  State<PaymentGot> createState() => _PaymentGotState();
}

class _PaymentGotState extends State<PaymentGot> {
  TextEditingController txtpname = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtdate = TextEditingController();
  TextEditingController txttime = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  dbClient dbc = dbClient();

  void getData() async {
    homeController.productList.value =
        await dbc.productreadData(id: homeController.data!.id!);
    homeController.addition();
    homeController.homeAddition();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Add Payment"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: txtpname,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                hintText: "Enter Product Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: txtprice,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(),
                hintText: "Enter Price",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: txtdate,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () async {
                    datepikerDilog();
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: "Enter Date",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: txttime,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () {
                    timepickerdilog();
                  },
                  icon: const Icon(Icons.timelapse),
                ),
                border: const OutlineInputBorder(),
                hintText: "Enter Time",
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("CANCEL"),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        dbc.productinsertData(
                            txtpname.text,
                            txtprice.text,
                            txtdate.text,
                            txttime.text,
                            int.parse(homeController.data!.id!),
                            0);
                        getData();
                        Get.back();
                      },
                      child: const Text("SAVE"),
                    )),
              ),
            ],
          )
        ],
      ),
    ));
  }

  void datepikerDilog() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(3000));
    homeController.getData(date);
    if (date != null) {
      txtdate.text = DateFormat('dd-MM-yyyy').format(date);
    }
  }

  void timepickerdilog() async {
    TimeOfDay? t1 =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t1 != null) {
      DateTime parsedtime =
          DateFormat.jm().parse(t1.format(context).toString());

      String formetdtime = DateFormat('hh:mm').format(parsedtime);

      txttime.text = formetdtime;
    }
  }
}
