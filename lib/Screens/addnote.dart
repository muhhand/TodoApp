import 'package:flutter/material.dart';
import 'package:todo_app/Screens/HomeM.dart';
import 'package:todo_app/DB/sqldb.dart';

class AddNotes extends StatelessWidget {
  AddNotes({Key? key}) : super(key: key);

  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(hintText: "Add Note"),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: InputDecoration(hintText: "Color"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                     int response = await sqlDb.insertData('''INSERT INTO notes (note,title,color) VALUES( "${note.text}","${title.text}","${color.text}")''');
                     print("insert Success");
                     if (response > 0){
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()), (route) => false);
                     }
                    },
                    child: Text("Add Note"),
                    textColor: Colors.white,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
