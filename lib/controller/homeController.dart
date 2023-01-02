import 'package:get/get.dart';
import 'package:khatabook/modal/modal.dart';
import 'package:khatabook/view/db.dart';

class HomeController extends GetxController{
  RxList<Map> cList = <Map>[].obs;
  Modal? data;
  RxInt total = 0.obs;
  RxInt pending = 0.obs;
  RxInt hometotal = 0.obs;
  RxInt homepending = 0.obs;
  RxString FilterDate = "".obs;

  RxList<Map> productList = <Map>[].obs;
  RxList<Map> productList1 = <Map>[].obs;

productModal? claint;

  int i=0;

  var date = DateTime.now();

  void getData(dynamic date1)
  {
    date = date1;
  }

  void addition() {

    int index = 0;
    total.value=0;
    pending.value=0;

    for(index=0;index<productList.length;index++) {
      if (productList[index]["paymentStatus"] == 0) {
        total.value = total.value + productList[index]["price"] as int;
      }
      else {
        pending.value = pending.value + productList[index]["price"] as int;
      }
    }

    print("${total.value}  ${pending.value}");
  }

  //======================================================

  void homeAddition() async{

    dbClient dbc = dbClient();

    productList1.value =
        await dbc.productreadData();

    int index = 0;
    hometotal.value=0;
    homepending.value=0;

    for(index=0;index<productList1.length;index++) {
      if (productList1[index]["paymentStatus"] == 0) {
        hometotal.value = hometotal.value + productList1[index]["price"] as int;
      }
      else {
        homepending.value = homepending.value + productList1[index]["price"] as int;
      }
    }

    print("${hometotal.value}  ${homepending.value}");
  }
}