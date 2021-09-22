import 'package:flutter/material.dart';

class Edit extends StatelessWidget {
  Edit({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _countryController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name:',
              ),
            ),
            TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age:',
                )),
            TextField(
                controller: _countryController,
                decoration: InputDecoration(
                  labelText: 'Country:',
                )),
            TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email:',
                )),
            ElevatedButton(
              onPressed: () {
                //code edit
              }, child: Text('Edit'))
          ],
        ),
      ),
    );
  }
}
