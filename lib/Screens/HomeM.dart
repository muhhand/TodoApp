import 'package:flutter/material.dart';
import 'package:todo_app/Screens/editenote.dart';
import 'package:todo_app/DB/sqldb.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  List notes = [];
  bool isLoading = true;

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    isLoading = false;
    if (this.mounted){
      setState((){

      });
    }
  }

@override
 void initState(){
    readData();
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TODO',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: isLoading == true ?
          Center(child:
          Text("Loading...."))
          : Container(
        color: Colors.grey.shade200,
        child: ListView(
          children: [
            MaterialButton(
              onPressed: () async {
                await sqlDb.mydeleteDatabase();
              },
              child: Text('Delete Database'),
            ),
            ListView.builder(
                itemCount: notes.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Card(
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    child: ListTile(
                      title: Text("${notes[i]['title']}"),
                      subtitle: Text("${notes[i]['note']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=> EditeNotes(
                                    color: notes[i]['color'],
                                    note: notes[i]['note'],
                                    title: notes[i]['title'],
                                    id: notes[i]['id'],
                              ))
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              int response = await sqlDb.deletedata(
                                  "DELETE FROM notes WHERE id = ${notes[i]['id']}");
                              if (response > 0) {
                                notes.removeWhere((element) => element['id'] == notes[i]['id']);
                                setState((){

                                });
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
