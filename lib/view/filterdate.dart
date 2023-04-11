// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/view/db.dart';

class FilterDate extends StatefulWidget {
  const FilterDate({Key? key}) : super(key: key);

  @override
  State<FilterDate> createState() => _FilterDateState();
}

class _FilterDateState extends State<FilterDate> {
  HomeController homeController = Get.put(HomeController());

  TextEditingController txtdate = TextEditingController();

  dbClient db = dbClient();

  void getData() async {
    homeController.productList.value =
        await db.filterRead(homeController.FilterDate.value);
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
        title: const Text("Check Pending Money"),
        actions: [
          IconButton(
              onPressed: () {
                datepikerDilog();
              },
              icon: const Icon(Icons.calendar_month))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: homeController.productList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 50,
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          color: const Color(0xff676262),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${homeController.productList[index]['currentDate']}",
                                            style: const TextStyle(
                                                color: Color(0xffffffff)),
                                          ),
                                          Text(
                                            "${homeController.productList[index]['time']}",
                                            style: const TextStyle(
                                                color: Color(0xffb0abab)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${homeController.productList[index]['productname']}",
                                        style: const TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 75,
                                      alignment: Alignment.center,
                                      color: const Color(0xffd90d0d),
                                      child: homeController.productList[index]
                                                  ['paymentStatus'] ==
                                              1
                                          ? Text(
                                              "${homeController.productList[index]['price']}",
                                              style: const TextStyle(
                                                  color: Color(0xffffffff)),
                                            )
                                          : const Text(""),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 75,
                                      alignment: Alignment.center,
                                      color: const Color(0xff339407),
                                      child: homeController.productList[index]
                                                  ['paymentStatus'] ==
                                              0
                                          ? Text(
                                              "${homeController.productList[index]['price']}",
                                              style: const TextStyle(
                                                  color: Color(0xffffffff)),
                                            )
                                          : const Text(""),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
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
      homeController.FilterDate.value = DateFormat('dd-MM-yyyy').format(date);
    }
    getData();
  }
}
