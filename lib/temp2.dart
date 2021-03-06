//import 'dart:async';
//import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter/src/widgets/navigator.dart';

class temp extends StatefulWidget {
  @override
  _Breakfastlist createState() => _Breakfastlist();
}

class _Breakfastlist extends State<temp> {
  List<String> breakfast_list = <String>['test1', 'test2'];
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  int listLength = 0;

// WHEN ITEM IS ADDED TO THE LIST

// BREAKFAST SCREEN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Center(
          child: Text('Breakfast'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/breakfast.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.separated(
            itemCount: listLength = breakfast_list.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(breakfast_list[index]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          print('addItem called'),
          showDialog<String>(
            context: context,
            child: AlertDialog(
              contentPadding: const EdgeInsets.all(17),
              content: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: myController,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Enter the food item',
                        labelStyle: TextStyle(
                          fontSize: 35,
                          height: 0.75,
                        ),
                        hintText: 'Eg. Pizza',
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text(' CANCEL'),
                  onPressed: () => {
                    Navigator.pop(context),
                  },
                ),
                FlatButton(
                    child: const Text('ADD'),
                    onPressed: () => {
                          if (myController.text != null)
                            {
                              setState(() {
                                breakfast_list.insert(0, myController.text);
                              }),
                              Navigator.pop(context),
                              myController.text = '',
                            }
                        }),
              ],
            ),
          )
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
