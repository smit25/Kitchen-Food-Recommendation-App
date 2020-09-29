import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'breakfast.dart';
import 'lunch.dart';
import 'dinner.dart';
import 'snacks.dart';
//import 'temp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitchen Cart',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
      ),
      home: homePage(),
    );
  }
}

class Button extends StatelessWidget {
  Button(this.name, this.check);
  final name;
  final int check;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => {
        if (check == 0)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Breakfast(),
              ),
            )
          },
        if (check == 1)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Lunch(),
              ),
            )
          },
        if (check == 2)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Snacks(),
              ),
            )
          },
        if (check == 3)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dinner(),
              ),
            )
          },
      },
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      color: Colors.green,
      textColor: Colors.white,
      hoverColor: Colors.blue,
      splashColor: Colors.white,
      child: Text(name, style: TextStyle(fontSize: 20)),
    );
  }
}

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var column = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Button('Breakfast', 0),
          Button('Lunch', 1),
          Button('Snacks', 2),
          Button('Dinner', 3),
        ]);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          title: Center(
            child: Text('Kitchen Cart'),
          ),
        ),
        body: Center(child: column),
      ),
    );
  }
}

/*Future tobreakfast(context) async {
  //Navigator.push(context, MaterialPageRoute(builder: (context) => Breakfast()));
}

Future tolunch(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Lunch()));
}

Future tosnacks(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Snacks()));
}

Future todinner(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Dinner()));
}
*/
