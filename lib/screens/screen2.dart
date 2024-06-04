import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:laocaldatabase/screens/screen1.dart';
import 'package:laocaldatabase/screens/screen3.dart';

import '../dbservice.dart';
import '../model/user_model.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<Person> personList = [];
  
  @override
  void initState() {
    super.initState();
    loadPersons();

  }
  Future<void> _navigateToUpdateScreen(Person person,int index) async {
    final updatedPerson = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Screen3(
          name: person.name,
          password: person.password,
          email: person.email,
          age: person.age,
          phone: person.phone,
        ),
      ),
    );
    if (updatedPerson != null) {
      setState(() {
        personList[index] = updatedPerson;
      });
    }
  }

  Future<void> loadPersons() async {
    final persons = await getPerson();

    setState(() {
      personList = persons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your details'),
        backgroundColor: Colors.grey,
      ),
      body: personList.isEmpty
          ? Center(
              child:Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:MainAxisAlignment.center ,
                children: [
                  const Text('THERE IS NO DATA ,CLICK THE ADD BUTTON TO ADD DATA '),
                  SizedBox(height: 50,),
                  ElevatedButton(
                    style: ButtonStyle(fixedSize: MaterialStatePropertyAll(Size(200, 50))),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Screen1(),));
                      },
                      child: const Text('Add')),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: personList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return listContainer(personList[index],index);
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Screen1(),));
                    },
                    child: const Text('Add')),
              ],
            ),
    );
  }

  Widget listContainer(Person person,int index) => Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        height: 200,
        width: MediaQuery.of(context).size.width - 5.0,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadiusDirectional.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Name : ${person.name}'),
            Text('Password : ${person.password}'),
            Text('Email : ${person.email}'),
            Text('Phone : ${person.phone}'),
            Text('Age : ${person.age}'),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 100,
                ),
                ElevatedButton(
                    onPressed:  () async {
                 await _navigateToUpdateScreen(person,index);
                  },
                    child: const Text('update')),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await deletePerson(person.phone);
                      loadPersons();
                    },
                    child: const Text('delete')),
              ],
            ),
          ],
        ),
      );
}
