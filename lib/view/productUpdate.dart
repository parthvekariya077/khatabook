import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/view/db.dart';

class ProductUpate extends StatefulWidget {
  const ProductUpate({Key? key}) : super(key: key);

  @override
  State<ProductUpate> createState() => _ProductUpateState();
}

class _ProductUpateState extends State<ProductUpate> {
  TextEditingController txtdate = TextEditingController();
  TextEditingController txttime = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtid = TextEditingController();

  dbClient db = dbClient();

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Product Edit'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: txtname,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                hintText: "Enter Name",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(),
                hintText: "Enter Amount",
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
                    icon: const Icon(Icons.date_range)),
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
                    icon: const Icon(Icons.timelapse)),
                border: const OutlineInputBorder(),
                hintText: "Enter Time",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    db.productupdateData(
                        homeController.claint!.pid!,
                        txtname.text,
                        txtprice.text,
                        txtdate.text,
                        txttime.text);
                  },
                  child: const Text("update")),
              ElevatedButton(onPressed: () {}, child: const Text("delete")),
            ],
          ),
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
          // ignore: use_build_context_synchronously
          DateFormat.jm().parse(t1.format(context).toString());

      String formetdtime = DateFormat('hh:mm').format(parsedtime);

      txttime.text = formetdtime;
    }
  }
}
