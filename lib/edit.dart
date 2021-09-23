import 'package:bomba_sqlite/user.dart';
import 'package:flutter/material.dart';
import 'package:bomba_sqlite/databasehandler.dart';

class Edit extends StatefulWidget {
  Edit({Key? key, required this.passUser}) : super(key: key);

  final User passUser;

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  late Databasehandler handler;

  @override
  void initState() {
    super.initState();
    this.handler = Databasehandler();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController()
      ..text = widget.passUser.name;
    TextEditingController _ageController = TextEditingController()
      ..text = widget.passUser.age.toString();
    TextEditingController _countryController = TextEditingController()
      ..text = widget.passUser.country.toString();
    TextEditingController _emailController = TextEditingController()
      ..text = widget.passUser.email.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Center(
        child: Container(
          width: 250,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                      onPressed: () {
                        //code edit
                        //define user
                        User user = User(
                            id: widget.passUser.id,
                            name: _nameController.text,
                            age: int.parse(_ageController.text),
                            country: _countryController.text,
                            email: _emailController.text);
                        //guna function dari handler
                        this.handler.updateUser(user);
                        Navigator.pop(context);
                      },
                      child: Text('Edit')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
