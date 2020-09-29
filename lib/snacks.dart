//import 'dart:async';
//import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter/src/widgets/navigator.dart';

class Snacks extends StatefulWidget {
  @override
  _SnacksList createState() => _SnacksList();
}

class _SnacksList extends State<Snacks> {
  List<String> snacks_list = <String>['test1', 'test2'];
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  int listLength = 0;
  @override
  void initState() {
    super.initState();
    _fetchList();
  }

// GET LIST FROM SHARED PREFERENCES

  Future<void> _fetchList() async {
    final prefs = await SharedPreferences.getInstance();
    var tempList = prefs.getStringList("snacks") ?? [];
    setState(() {
      snacks_list = tempList;
    });
  }

  Future<bool> _saveList() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList("snacks", snacks_list);
  }

// SNACKS SCREEN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Center(
          child: Text('SNACKS       '),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Snacks.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.separated(
            itemCount: listLength = snacks_list.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  snacks_list[index],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                                snacks_list.insert(0, myController.text);
                              }),
                              _saveList(),
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
        backgroundColor: Colors.blue,
      ),
    );
  }
}
