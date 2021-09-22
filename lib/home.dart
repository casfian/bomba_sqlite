import 'package:bomba_sqlite/databasehandler.dart';
import 'package:bomba_sqlite/user.dart';
import 'package:flutter/material.dart';

//secondary class atau UI
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Databasehandler handler;

  //functions sini
  //1. create data awalan
  Future<int> createUsers() async {
    User john = User(
        name: 'John', age: 24, country: 'Malaysia', email: 'john@gmail.com');
    User david = User(
        name: 'David', age: 26, country: 'Malaysia', email: 'david@gmail.com');
    User abu =
        User(name: 'Abu', age: 28, country: 'Malaysia', email: 'abu@gmail.com');
    User ali =
        User(name: 'Ali', age: 29, country: 'Malaysia', email: 'ali@gmail.com');
    List<User> listOfUsers = [john, david, abu, ali];
    return await this.handler.insertUsers(listOfUsers);
  }

  //2. Create new Data
  Future<int> adduser(
      String name, int age, String country, String email) async {
    //define user
    User user = User(name: name, age: age, country: country, email: email);
    //code dari Handler
    return await this.handler.insertUser(user);
  }

  void openWindowToCreateUser() {
    final _nameController = TextEditingController();
    final _ageController = TextEditingController();
    final _countryController = TextEditingController();
    final _emailController = TextEditingController();

    AlertDialog openwindow = AlertDialog(
      title: Text('Add New User'),
      content: Container(
        width: 250,
        height: 270,
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
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              //function utk tambah data
              adduser(_nameController.text, int.parse(_ageController.text),
                  _countryController.text, _emailController.text);
              setState(() {
                //utk refresh screen
              });
              Navigator.pop(context);
            },
            child: Text('OK')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return openwindow;
        });
  }

  @override
  void initState() {
    super.initState();
    this.handler = Databasehandler(); //utk On kan Database
    // this.handler.initialiseDB().whenComplete(() async {
    //   await this.createUsers(); //create data awalan sekiranya perlu
    //   setState(() {

    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sqlite Database Demo'),
      ),
      body: FutureBuilder(
          future: this.handler.retrieveUsers(), //sumber data aka data source
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            //check kalau ada data
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey<int>(snapshot.data![index].id!),
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                      ),
                      onDismissed: (DismissDirection direction) async {
                        //action sini
                        await this
                            .handler
                            .deleteUser(snapshot.data![index].id!);
                        setState(() {
                          snapshot.data!.remove(snapshot.data![index]);
                        });
                      },
                      child: ListTile(
                        title: Text(snapshot.data![index].name),
                        subtitle: Text(snapshot.data![index].email.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            //code utk edit
                          },
                          icon: Icon(Icons.edit),),
                      ),
                    );
                  });
            } else {
              //paparkan data loading...
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //call function utk add data
          openWindowToCreateUser();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
