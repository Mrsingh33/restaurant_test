import 'package:bloc_test/Screen/Home/homePageController.dart';
import 'package:bloc_test/localDatabase/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home/menuDataModel.dart';

class MyHomePageScreen extends StatefulWidget {
  const MyHomePageScreen({Key? key}) : super(key: key);

  @override
  State<MyHomePageScreen> createState() => _MyHomePageScreenState();
}

class _MyHomePageScreenState extends State<MyHomePageScreen> {
  final HomePageController _homePageController = Get.put(HomePageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePageController.populorItemsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Order",
                    style: TextStyle(fontSize: 20),
                  ),
                  Obx(() => Text(
                        "\$  ${_homePageController.orderValue.value.toString()}",
                        style: const TextStyle(fontSize: 20),
                      ))
                ],
              ),
              onPressed: () async {
                final _databaseInstance = MyDatabase.sharedInstance;
                for (int i = 0; i < _homePageController.order.length; i++) {

                  final isDataHave  = await MyOrdersDao(_databaseInstance).getOrderBYTitle(_homePageController.order[i].title);

                  if(isDataHave.isNotEmpty){
                    int newValue = isDataHave[0].quantity + int.parse(_homePageController.order[i].quantity.toString());
                    print('newValue $newValue');
                    MyOrdersDao(_databaseInstance).updateOrder(_homePageController.order[i].title, newValue);
                  }else{
                    MyOrdersDao(_databaseInstance)
                        .addOrders(_homePageController.order[i]);
                  }


                }
                Get.delete<HomePageController>();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) => const MyHomePageScreen()),
                        (Route<dynamic> route) => route is MyHomePageScreen
                );


              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              )),
        ),
      ),
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => _homePageController.showPopularTab.value
              ? FutureBuilder(
                  future: _homePageController.populorItemsData(), // async work
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Text('Loading....');
                      default:
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          if (snapshot.data == {}) {
                            return Container();
                          } else {
                            print(snapshot.data);

                            return snapshot.data == {}
                                ? Container()
                                : Container(
                                    padding: const EdgeInsets.all(10),
                                    child: ExpandableListView(
                                        title: 'Popular Items',
                                        apiData: snapshot.data));
                          }
                        } else {
                          return Container();
                        }
                    }
                  },
                )
              : Container()),
          FutureBuilder(
            future: _homePageController.readJson(), // async work
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Text('Loading....');
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Container(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 800,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              String title = snapshot.data.keys.toList()[index];

                              return ExpandableListView(
                                  title: title, apiData: snapshot.data);
                            },
                            itemCount: snapshot.data.length,
                          ),
                        ));
                  }
              }
            },
          ),
        ],
      )),
    );
  }
}

class ExpandableListView extends StatefulWidget {
  String? title;
  var apiData;
  ExpandableListView({Key? key, this.title, this.apiData}) : super(key: key);

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = false;

  final HomePageController _homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black),
                ),
                IconButton(
                    icon: Center(
                      child: Icon(
                        expandFlag
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.grey,
                        size: 30.0,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    }),
              ],
            ),
          ),
          ExpandableContainer(
              expandedHeight: widget.title == 'Popular Items'
                  ? widget.apiData[widget.title].length * 70.0
                  : widget.apiData[widget.title].length * 40.0,
              expanded: expandFlag,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.grey),
                        color: Colors.grey.shade300),
                    child: ListTile(
                      leading: widget.apiData[widget.title][index].bestSeller
                          ? Container(
                        color: Colors.red,
                        padding: EdgeInsets.all(2),
                          child: const Text('Best Seller'))
                          : const Text('           '),
                      title: Text(
                        widget.apiData[widget.title][index].name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        "\$ ${widget.apiData[widget.title][index].price}",
                        style:
                            const TextStyle(fontSize: 22, color: Colors.grey),
                      ),
                      trailing: widget.apiData[widget.title][index].unit == 0
                          ? ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.apiData[widget.title][index].unit = 1;
                                  _homePageController.orderValue.value =
                                      _homePageController.orderValue.value +
                                          int.parse(widget
                                              .apiData[widget.title][index]
                                              .price
                                              .toString());
                                });
                                final myOrderData = MyOrderData(
                                    title: widget
                                        .apiData[widget.title][index].name,
                                    content: widget
                                        .apiData[widget.title][index].price
                                        .toString(),
                                    category: widget.title!,
                                    quantity: widget
                                        .apiData[widget.title][index].unit);
                                _homePageController.order.add(myOrderData);
                              },
                              child: const Text("ADD",
                                  style: TextStyle(fontSize: 30)),
                            )
                          : Container(
                              width: 75,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Theme.of(context).accentColor),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        _homePageController.order.removeLast();
                                        setState(() {
                                          widget.apiData[widget.title][index]
                                              .unit--;
                                          _homePageController.orderValue.value =
                                              _homePageController
                                                      .orderValue.value -
                                                  int.parse(widget
                                                      .apiData[widget.title]
                                                          [index]
                                                      .price
                                                      .toString());
                                        });
                                        final myOrderData = MyOrderData(
                                            title: widget
                                                .apiData[widget.title][index]
                                                .name,
                                            content: widget
                                                .apiData[widget.title][index]
                                                .price
                                                .toString(),
                                            category: widget.title!,
                                            quantity: widget
                                                .apiData[widget.title][index]
                                                .unit);
                                        _homePageController.order
                                            .add(myOrderData);
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 16,
                                      )),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white),
                                    child: Text(
                                      widget.apiData[widget.title][index].unit
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        _homePageController.order.removeLast();
                                        setState(() {
                                          widget.apiData[widget.title][index]
                                              .unit++;
                                          _homePageController.orderValue =
                                              _homePageController.orderValue +
                                                  int.parse(widget
                                                      .apiData[widget.title]
                                                          [index]
                                                      .price
                                                      .toString());
                                        });
                                        final myOrderData = MyOrderData(
                                            title: widget
                                                .apiData[widget.title][index]
                                                .name,
                                            content: widget
                                                .apiData[widget.title][index]
                                                .price
                                                .toString(),
                                            category: widget.title!,
                                            quantity: widget
                                                .apiData[widget.title][index]
                                                .unit);

                                        _homePageController.order
                                            .add(myOrderData);
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      )),
                                ],
                              ),
                            ),
                    ),
                  );
                },
                itemCount: widget.apiData[widget.title].length,
              ))
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget? child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 300.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        child: child,
        decoration:
            BoxDecoration(border: Border.all(width: 1.0, color: Colors.blue)),
      ),
    );
  }
}
