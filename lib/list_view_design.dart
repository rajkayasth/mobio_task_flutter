import 'package:flutter/material.dart';

enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class ListviewPage extends StatefulWidget {
  const ListviewPage({Key? key}) : super(key: key);

  @override
  State<ListviewPage> createState() => _ListviewPageState();
}

class _ListviewPageState extends State<ListviewPage> {
  BestTutorSite _site = BestTutorSite.javatpoint;
  String dropdownValue = 'One';

  List<String> spinnerItems = ['One', 'Two', 'Three', 'Four', 'Five'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: Image.asset(
                      "assets/images/test.jpg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Product name"),
                      Text("Product price"),
                      Row(
                        children: [
                          Radio(
                            value: BestTutorSite.javatpoint,
                            groupValue: _site,
                            onChanged: (BestTutorSite? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                          Text("Red"),
                          Radio(
                            value: BestTutorSite.javatpoint,
                            groupValue: _site,
                            onChanged: (BestTutorSite? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                          Text("Green"),
                          Radio(
                            toggleable: false,
                            activeColor: Colors.green,
                            value: BestTutorSite.javatpoint,
                            groupValue: _site,
                            onChanged: (BestTutorSite? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                          Text("Blue"),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.height / 2.5,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: DropdownButton<String>(
                          alignment: Alignment.center,
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                          underline: Container(
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? data) {
                            setState(() {
                              dropdownValue = data!;
                            });
                          },
                          items: spinnerItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
