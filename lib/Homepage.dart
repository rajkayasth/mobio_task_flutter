import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobio_task/list_view_design.dart';
import 'package:mobio_task/product_data_model.dart';

enum Coloring { Red, Green, Yellow }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Coloring _site = Coloring.Green;
  Coloring _sites = Coloring.Red;
  Coloring _sitees = Coloring.Yellow;
  String DropDown = "Select";
  String? singleRadioValue;

  Future<List<ProductModel>> ReadJsonData() async {
    //read json file
    final jsondata = await rootBundle.loadString('assets/files/products.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list.map((e) => ProductModel.fromJson(e)).toList();
  }

  String dropdownValue = 'Schroeder Valenzuela';

  List<String> spinnerItems = [
    'Schroeder Valenzuela',
    'Gamble Hendrix',
    'Pat Gray',
    'Morgan Weeks',
    'Corinne Finch'
  ];

  final List qntyController = [];
  // var qty;

  // void takeNumber(String? text, int index) {
  //   int number = int.parse(text!);
  //   qntyController.add(number);
  //   qntyController[index] = number;
  //   // print(qntyController);
  //   setState(() {
  //     qty
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            //in case if error found
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            //once data is ready this else block will execute
            // items will hold all the data of DataModel
            //items[index].name can be used to fetch name of product as done below
            var items = data.data as List<ProductModel>;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items == null ? 0 : items.length,
                      itemBuilder: (context, index) {
                        final checkBox = items[index].brands;
                        return Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30,
                                    child: ClipOval(
                                        child: Image.network(
                                            items[index].picture))),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          items[index].productName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 8, right: 8),
                                        child:
                                            Text(items[index].price.toString()),
                                      ),
                                      Row(
                                        children: [
                                          Radio(
                                              toggleable: true,
                                              value: Coloring.Red,
                                              groupValue: _site,
                                              onChanged: (Coloring? value) {
                                                _site = value!;
                                              }),
                                          Text("Red"),
                                          Radio(
                                              toggleable: true,
                                              value: Coloring.Red,
                                              groupValue: _sites,
                                              onChanged: (Coloring? value) {
                                                _sites = value!;
                                              }),
                                          Text("Green"),
                                          Radio(
                                              toggleable: true,
                                              value: Coloring.Red,
                                              groupValue: _sitees,
                                              onChanged: (Coloring? value) {
                                                _sitees = value!;
                                              }),
                                          Text("Blue"),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1)),
                                        child: DropdownButton<String>(
                                          hint: Text("Select Brand"),
                                          alignment: Alignment.center,
                                          value: dropdownValue,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                          underline: Container(
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (String? data) {
                                            setState(() {
                                              dropdownValue = data!;
                                            });
                                          },
                                          items: spinnerItems
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        autofocus: false,
                                        validator: (value) {
                                          RegExp regex = new RegExp(r'^.{6,}$');
                                          if (value!.isEmpty) {
                                            return ("Enter Quantity");
                                          }
                                        },
                                        onChanged: (value) {
                                          // print("Value" + index.toString());
                                          // takeNumber(value, index);
                                        },
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20, 15, 20, 15),
                                          hintText: "Enter Quantity",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print(qntyController);
                                          // print(qntyController);
                                          // print(qntyController[1]);
                                        },
                                        child: Text("Submit"),
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     // print(qntyController);
                //     // print(qntyController[1]);
                //   },
                //   child: Text("Submit"),
                // ),
              ],
            );
          } else {
            // show circular progress while data is getting fetched from json file
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
