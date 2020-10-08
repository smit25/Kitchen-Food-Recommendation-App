//import 'dart:async';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';
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

  String selectFood() {
    int list_len = snacks_list.length;
    Random random = new Random();
    int randomIndex = random.nextInt(list_len);
    return snacks_list[randomIndex];
  }

  AlertDialog addItem(myController) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
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
    );
  }

  Dialog itemSelect() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.orange[30],
        ),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      selectFood(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  ),
                ),
              ],
            )),
      ),
    );
  }

// BREAKFAST SCREEN
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: null,
              onPressed: () => {
                print('Random Selector pressed'),
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return itemSelect();
                    }),
              },
              tooltip: 'Recipe for the day',
              child: Icon(Icons.fastfood),
              backgroundColor: Colors.blueAccent,
            ),
            FloatingActionButton(
              heroTag: null,
              onPressed: () => {
                print('addItem called'),
                showDialog<String>(
                  context: context,
                  child: addItem(myController),
                ),
              },
              tooltip: 'Add Item',
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
