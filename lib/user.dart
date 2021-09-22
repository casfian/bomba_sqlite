class User {
  final int? id;
  final String name;
  final int? age;
  final String? country;
  final String? email;

  //constructor
  User(
      {this.id,
      required this.name,
       this.age,
       this.country,
       this.email}
      );

  //use mapping so that we can use it in JSOn or Database
  //2 type from and to
  User.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        age = res['age'],
        country = res['country'],
        email = res['email'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'country': country,
      'email': email
    };
  }
}
