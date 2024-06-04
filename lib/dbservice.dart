import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/user_model.dart';


    var database;

    Future<void>initial()async {
      database =await openDatabase(
        join(await getDatabasesPath(), 'person_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE person(phone TEXT PRIMARY KEY, name TEXT, age TEXT,email TEXT,password TEXT)',
          );
        },
        version: 1,
      );
    }

    Future<void> insertPerson(Person person) async {
      final db = await database;
       await db.insert(
        'person',
        person.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    Future<List<Person>> getPerson() async {
      final db = await database;
    final List<Map<String, dynamic>> personMaps = await db.query('person');
  //  print('database data :${personMaps}');
    List<Person> personData = List.generate(personMaps.length, (i)
    {
      return Person(
        name: personMaps[i]['name'],
        password: personMaps[i]['password'],
        email: personMaps[i]['email'],
        phone: personMaps[i]['phone'],
        age: personMaps[i]['age'],
      );
    });

    print('personsList${personData}');

 return  personData;
    }
Future<void> deletePerson(String phone) async {
      //print(phone);


  var res = await  database.delete(
    'person',
    where: 'phone = ?',
    whereArgs: [phone],
  );
  //print('helo');
  print(res);
    }

Future<void> updatePerson(Person person) async {
  final db = await database;
 var up= await db.update(
    'person',
    person.toMap(),
    where: 'phone = ?',
    whereArgs: [person.phone],
  );
 print('hello');
 print(up);

}
