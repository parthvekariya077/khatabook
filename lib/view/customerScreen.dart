import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khatabook/view/db.dart';
import 'package:khatabook/view/paymentGave.dart';
import 'package:khatabook/view/paymentGot.dart';
import 'package:khatabook/view/productUpdate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/homeController.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  HomeController homeController = Get.put(HomeController());

  dbClient dbc = dbClient();

  void getData() async {
    homeController.productList.value =
        await dbc.productreadData(id:homeController.data!.id!);
    homeController.addition();
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
        elevation: 0,
        title: Text("${homeController.data!.name}"),
        actions: [
          IconButton(
              onPressed: () {
                String number = 'tel:${homeController.data!.mobile}';
                launchUrl(Uri.parse(number));
              },
              icon: Icon(Icons.call))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Income",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                            fontSize: 25),
                      ),
                      Obx(
                        () => Text(
                          "₹ ${homeController.total.value}",
                          style: TextStyle(
                              color: Color(0xff21e81b),
                              fontWeight: FontWeight.w400,
                              fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Expense",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                            fontSize: 25),
                      ),
                      Obx(
                        () => Text(
                          "₹ ${homeController.pending.value}",
                          style: TextStyle(
                              color: Color(0xffca4e4a),
                              fontWeight: FontWeight.w400,
                              fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.picture_as_pdf,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.whatsapp,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.currency_rupee_sharp,
                    size: 30,
                  )),
            ],
          ),
          Divider(
            color: Color(0xff000000),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Date/Time"),
              ),
              Text("Remark"),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text("YouGave/Yougot"),
              ),
            ],
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: homeController.productList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 50,
                      child: InkWell(
                        onTap: () {
                          Get.to(ProductUpate());
                        },
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          color: Color(0xff676262),
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
                                            style: TextStyle(
                                                color: Color(0xffffffff)),
                                          ),
                                          Text(
                                            "${homeController.productList[index]['time']}",
                                            style: TextStyle(
                                                color: Color(0xffb0abab)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${homeController.productList[index]['productname']}",
                                        style: TextStyle(
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
                                      color: Color(0xffd90d0d),
                                      child: homeController.productList[index]
                                                  ['paymentStatus'] ==
                                              1
                                          ? Text(
                                              "${homeController.productList[index]['price']}",
                                              style: TextStyle(
                                                  color: Color(0xffffffff)),
                                            )
                                          : Text(""),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 75,
                                      alignment: Alignment.center,
                                      color: Color(0xff339407),
                                      child: homeController.productList[index]
                                                  ['paymentStatus'] ==
                                              0
                                          ? Text(
                                              "${homeController.productList[index]['price']}",
                                              style: TextStyle(
                                                  color: Color(0xffffffff)),
                                            )
                                          : Text(""),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(PaymentGave());
                        },
                        child: Text("YOU GAVE ₹"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffd90d0d)))),
                Container(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(PaymentGot());
                    },
                    child: Text("YOU GOT ₹"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff339407),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    ));
  }
}
