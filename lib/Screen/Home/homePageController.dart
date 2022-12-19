import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../localDatabase/database_helper.dart';
import 'menuDataModel.dart';

class HomePageController extends GetxController {

  RxInt orderValue = 0.obs;
  List order = [];
  RxBool showPopularTab = false.obs;
  final _databaseInstance = MyDatabase.sharedInstance;
  Future<Map<String, List<MenuDataModel>>> readJson() async {
    final String response = await rootBundle.loadString('assets/menu.json');
    final data = menuDataModelFromJson(response);

      return data;
// ...
  }

    Future<Map<String, List<MenuDataModel>>> populorItemsData() async {

    final myorder = await MyOrdersDao(_databaseInstance).getOrders();
    Map<String, List<MenuDataModel>> popularitem = {};
    List<MenuDataModel> data = [];
    if(myorder.isNotEmpty){


      print("isNotEmpty $myorder");

      for(int i = 0 ; i < 3; i++){
        print(myorder[i].content.toString());

        MenuDataModel prod = MenuDataModel(
            name: myorder[i].title,
            price: int.parse(myorder[i].content.toString()),
            inStock: true,
            bestSeller: i== 0 ? true : false ,
            unit: 0);


        data.add(prod);
      }

      popularitem.addAll({
        'Popular Items' : data
      });
      showPopularTab(true);
    }else{
      showPopularTab(false);
      popularitem.clear();
    }



    return popularitem;





  }







}

