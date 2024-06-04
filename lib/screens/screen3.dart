import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laocaldatabase/dbservice.dart';
import 'package:laocaldatabase/model/user_model.dart';
import 'package:laocaldatabase/screens/screen2.dart';
import 'package:sqflite/sqflite.dart';

class Screen3 extends StatefulWidget {
  final String name;
  final String password;
  final String email;
  final String age;
  final String phone;
  const Screen3(
      {super.key,
      required this.name,
      required this.password,
      required this.email,
      required this.age,
      required this.phone});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _namecontroller;
  late TextEditingController _passwordcontroller;
  late TextEditingController _emailcontroller;
  late TextEditingController _agecontroller;
  late TextEditingController _phonecontroller;


  @override
  void initState() {
    super.initState();
    _namecontroller = TextEditingController(text: widget.name);
    _passwordcontroller = TextEditingController(text: widget.password);
    _emailcontroller = TextEditingController(text: widget.email);
    _agecontroller = TextEditingController(text: widget.age);
    _phonecontroller = TextEditingController(text: widget.phone);
  }

  @override
  void dispose(){
    super.dispose();
    _namecontroller.dispose();
    _passwordcontroller.dispose();
    _emailcontroller.dispose();
    _agecontroller.dispose();
    _phonecontroller.dispose();

  }




  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('Update'),
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
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed:()
                          async {
                            if (_formkey.currentState!.validate()) {
                              Person updated= Person(
                                name: _namecontroller.text,
                                password: _passwordcontroller.text,
                                email: _emailcontroller.text,
                                phone: _phonecontroller.text,
                                age: _agecontroller.text,
                              );
                              await updatePerson( updated);
                              Navigator.pop(context, updated);
                            }

                          },
                        child: const Text('Update')),
                    const SizedBox(
                      width: 150,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancle')),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

