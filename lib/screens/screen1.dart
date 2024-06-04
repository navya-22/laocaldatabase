import 'package:flutter/material.dart';
import 'package:laocaldatabase/dbservice.dart';
import 'package:laocaldatabase/model/user_model.dart';
import 'package:laocaldatabase/screens/screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _agecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  @override
  void dispose() {
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    _emailcontroller.dispose();
    _phonecontroller.dispose();
    _agecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FORM'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _namecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' Please Enter User Name ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'User_Name'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordcontroller,
                validator: (value) {
                  RegExp regex = RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&~]).{8,}$');

                  if (value!.isEmpty) {
                    return 'Please enter Password';
                  } else {
                    print(regex.hasMatch(value));
                    if (regex.hasMatch(value)) {
                      return null;
                    } else {
                      return 'Enter a valid password';
                    }
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailcontroller,
                validator: (value) {
                  RegExp regex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~)]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value!.isEmpty) {
                    return ('please enter your email');
                  } else {
                    if (!regex.hasMatch(value)) {
                      return 'please enter a valid email';
                    }
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Email'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _agecontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' Please Enter Age ';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phonecontroller,
                validator: (value) {
                  RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

                  if (value == 0) {
                    return 'Please enter mobile number';
                  } else if (!regExp.hasMatch(value!)) {
                    return 'Please enter valid mobile number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Phone'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    String name = _namecontroller.text;
                    String password = _passwordcontroller.text;
                    String email = _emailcontroller.text;
                    String phone = _phonecontroller.text;
                    String age = _agecontroller.text;
                    if (_formkey.currentState!.validate()) {
                      Person data  = Person(
                          name: name,
                          password: password,
                          email: email,
                          phone: phone,
                          age: age);
                      await insertPerson(data);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Screen2(),
                          ));
                    }
                  },
                  child: const Text('save')),
            ],
          ),
        ),
      ),
    );
  }
}
