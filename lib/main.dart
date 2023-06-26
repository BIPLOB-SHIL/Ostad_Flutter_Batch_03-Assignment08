import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Task Management",
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Task> tasks =[];


  final TextEditingController _titleFieldController = TextEditingController();
  final TextEditingController _descriptionFieldController = TextEditingController();
  final TextEditingController _deadlineFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Management"),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        itemCount: tasks.length,
        itemBuilder: (context,index){
          return ListTile(
            onLongPress: (){
              showTasksItemBottomSheet(tasks[index].title,tasks[index].description,tasks[index].deadline,index);
            },
            title: Text(tasks[index].title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            subtitle: Text(tasks[index].description),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        onPressed: (){
          if(mounted) {
            showDialog(context: context, builder: (context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: const Text('Add Task'),
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _titleFieldController,
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                          decoration: const InputDecoration(hintText: "Title",
                          border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                          controller: _descriptionFieldController,
                          decoration: const InputDecoration(hintText: "Description",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                          controller: _deadlineFieldController,
                          decoration: const InputDecoration(hintText: "Deadline",
                          border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: (){
                          if(_titleFieldController.text.trim().isNotEmpty &&
                          _descriptionFieldController.text.trim().isNotEmpty &&
                            _deadlineFieldController.text.trim().isNotEmpty) {
                            tasks.add(Task(_titleFieldController.text.trim(),
                                _descriptionFieldController.text.trim(),
                                _deadlineFieldController.text.trim()));

                            if (mounted) {
                              setState(() {});
                            }
                            _titleFieldController.clear();
                            _descriptionFieldController.clear();
                            _deadlineFieldController.clear();
                            Navigator.pop(context);
                          }
                        }, child: const Text("Save")
                    ),
                  ],

                ),
              );
            },);

          }
        },
      ),

    );
  }

  void showTasksItemBottomSheet(String title, String description, String deadline, int index){
    showModalBottomSheet(context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child:  Text("Task Details",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Text("Title:$title"),
            Text("Description:$description"),
            Text("Days Required:$deadline"),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                  onPressed: (){
                    if(mounted){
                      tasks.removeAt(index);
                      Navigator.pop(context);
                      setState(() {

                      });
                    }

              }, child: const Text("Delete")),
            )

          ],
        ),
      );
    },);

  }

}


class Task {
  String title, description, deadline;

  Task (this.title,this.description,this.deadline);
}



