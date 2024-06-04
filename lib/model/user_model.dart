



class Person {
  final String name;
  final String password;
  final String email;
  final String phone;
  final String age;

  Person({
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
    required this.age
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'password': password,
      'email': email,
      'phone': phone,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Person{name : $name,password :$password, email: $email,'
        'phone : $phone,age : $age}';
  }
}


