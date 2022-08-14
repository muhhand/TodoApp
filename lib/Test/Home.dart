import 'package:flutter/material.dart';
import 'package:todo_app/DB/sqldb.dart';

class Hometest extends StatelessWidget {

  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SqlfLite'),),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () async {
                int response = await sqlDb.insertData("INSERT INTO 'notes' ('note') VALUES ('Note Two') ");
                print(response);
              },
              color: Colors.red,
              child: Text('Insert Data',style: TextStyle(color: Colors.white),),
            ),
            MaterialButton(
              onPressed: () async {
              List<Map> response = await sqlDb.readData("SELECT * FROM 'notes'");
              print("${response}");
              },
              color: Colors.red,
              child: Text('Read Data',style: TextStyle(color: Colors.white),),
            ),
            MaterialButton(
              onPressed: () async {
                int response = await sqlDb.updateData("UPDATE 'notes' SET 'note' = 'fuck' WHERE id =1");
                print("${response}");
              },
              color: Colors.red,
              child: Text('Update Data',style: TextStyle(color: Colors.white),),
            ),
            MaterialButton(
              onPressed: () async {
                int response = await sqlDb.deletedata("DELETE FROM 'notes' WHERE id = 2");
                print("${response}");
              },
              color: Colors.red,
              child: Text('Delete Data',style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
