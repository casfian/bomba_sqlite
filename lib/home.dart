import 'package:flutter/material.dart';

//secondary class atau UI
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqlite Database Demo'),
      ),
      body: ListView.builder(
          itemCount: 25,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Data Users'),
            );
          }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //call function utk add data
            } ,
            child: Icon(Icons.add),),
    );
  }
}
