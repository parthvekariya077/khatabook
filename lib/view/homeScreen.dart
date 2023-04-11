// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/modal/modal.dart';
import 'package:khatabook/view/customerDetails.dart';
import 'package:khatabook/view/customerScreen.dart';
import 'package:khatabook/view/db.dart';
import 'package:khatabook/view/filterdate.dart';

import '../controller/homeController.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController utxtname = TextEditingController();
  TextEditingController utxtnumber = TextEditingController();
  TextEditingController utxtaddress = TextEditingController();

  dbClient db = dbClient();

  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    homeController.cList.value = await db.readData();
    homeController.homeAddition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          title: const Text(
            "Khatabook",
            style: TextStyle(fontSize: 22),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(const FilterDate());
                },
                icon: const Icon(Icons.filter_alt))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "You Will Give",
                              style: TextStyle(color: Color(0xffffffff)),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "₹ ${homeController.homepending.value}",
                              style: const TextStyle(
                                color: Color(0xffca4e4a),
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: Container(
                          height: 60,
                          width: 1,
                          color: const Color(0xff45586a),
                        ),
                      ),
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "You Will Give",
                              style: TextStyle(color: Color(0xffffffff)),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "₹ ${homeController.hometotal.value}",
                              style: const TextStyle(
                                  color: Color(0xff21e81b), fontSize: 40),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Divider(
                      height: 1,
                      color: Color(0xff45586a),
                    ),
                  ),
                  const Text(
                    "VIEW HISTORY >",
                    style: TextStyle(fontSize: 20, color: Color(0xffffffff)),
                  )
                ],
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: homeController.cList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          homeController.data = Modal(
                              name: homeController.cList.value[index]["name"],
                              mobile: homeController.cList.value[index]
                                  ["number"],
                              id: homeController.cList.value[index]["id"]
                                  .toString());
                          Get.to(const CustomerScreen());
                        },
                        child: ListTile(
                          leading: Text(
                              "${homeController.cList.value[index]["id"]}"),
                          title: Text(
                              "${homeController.cList.value[index]["name"]}"),
                          subtitle: Text(
                              "${homeController.cList.value[index]["number"]}"),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    db.deleteData(
                                        "${homeController.cList[index]["id"]}");
                                    getData();
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                                IconButton(
                                  onPressed: () {
                                    utxtname = TextEditingController(
                                        text: homeController
                                            .cList.value[index]["name"]
                                            .toString());
                                    utxtnumber = TextEditingController(
                                        text: homeController
                                            .cList.value[index]["number"]
                                            .toString());
                                    utxtaddress = TextEditingController(
                                        text: homeController
                                            .cList.value[index]["address"]
                                            .toString());

                                    Get.defaultDialog(
                                        content: Column(
                                      children: [
                                        TextField(
                                          controller: utxtname,
                                          decoration: const InputDecoration(
                                              hintText: "Name"),
                                        ),
                                        TextField(
                                          controller: utxtnumber,
                                          decoration: const InputDecoration(
                                              hintText: "Number"),
                                        ),
                                        TextField(
                                          controller: utxtaddress,
                                          decoration: const InputDecoration(
                                              hintText: "Adderss"),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              db.update(
                                                  utxtname.text,
                                                  utxtnumber.text,
                                                  utxtaddress.text,
                                                  "${homeController.cList[index]["id"]}");
                                              getData();
                                              Get.back();
                                            },
                                            child: const Text("update")),
                                      ],
                                    ));
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(const Customer());
          },
          label: const Text(
            "ADD CUSTOMER",
            style: TextStyle(fontSize: 18),
          ),
          icon: const Icon(
            Icons.add,
            size: 26,
          ),
        ),
      ),
    );
  }
}
