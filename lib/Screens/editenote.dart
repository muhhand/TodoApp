import 'package:flutter/material.dart';
import 'package:todo_app/Screens/HomeM.dart';
import 'package:todo_app/DB/sqldb.dart';

class EditeNotes extends StatefulWidget {
  final title;
  final note;
  final color;
  final id;

  EditeNotes({Key? key, this.title, this.note, this.color, this.id}) : super(key: key);

  @override
  State<EditeNotes> createState() => _EditeNotesState();
}

class _EditeNotesState extends State<EditeNotes> {
  SqlDb sqlDb = SqlDb();

  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();

  TextEditingController title = TextEditingController();

  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

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
                      int response = await sqlDb.updateData('''
                      UPDATE notes SET
                       note = "${note.text}" ,
                        title = "${title.text}" ,
                        color = "${color.text}" 
                        WHERE id = ${widget.id}
                      ''');
                      print("insert Success");
                      if (response > 0){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home()), (route) => false);
                      }
                    },
                    child: Text("Edite Note"),
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
