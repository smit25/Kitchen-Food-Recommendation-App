import 'package:flutter/material.dart';
import 'dinner/tasty.dart';
import 'dinner/healthy.dart';

class Dinner extends StatefulWidget {
  @override
  _DinnerList createState() => _DinnerList();
}

class Button extends StatelessWidget {
  Button(this.name, this.check);
  final check;
  final name;
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => {
        if (check == 0)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Healthy(),
              ),
            )
          },
        if (check == 1)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Tasty(),
              ),
            ),
          },
      },
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      color: Colors.lightGreen,
      textColor: Colors.white,
      hoverColor: Colors.blue,
      splashColor: Colors.white,
      child: Text(name, style: TextStyle(fontSize: 20)),
    );
  }
}

class _DinnerList extends State<Dinner> {
  @override
  Widget build(BuildContext context) {
    var column = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Button('Healthy', 0),
          Button('Tasty', 1),
        ]);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Dinner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Center(
            child: Text('DINNER       '),
          ),
        ),
        body: Center(child: column),
      ),
    );
  }
}
