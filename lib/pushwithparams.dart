import 'package:flutter/material.dart';

void main()=>runApp(MaterialApp(title: 'Todos',
  initialRoute: TodoList.routeName,
  routes: {
    TodoList.routeName: (_)=> const TodoList(),
    TodoDetail.routeName: (_)=> const TodoDetail()
  },
));

class TodoList extends StatelessWidget{
  const TodoList({super.key});

  static const routeName = '/';


  List<Widget> _buildRows(BuildContext context){
    List<Widget> widgets = [];
    for(int i =0;i<20;i++){
      widgets.add(
        GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, TodoDetail.routeName,arguments: i);
            },
            child: Padding(padding: const EdgeInsets.all(16),child: Text('Todo $i',style: const TextStyle(fontSize: 16),))
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(appBar: AppBar(title: const Text('Todos'),
      ),body: ListView(
        children: _buildRows(context)
      ));
  }

}

class TodoDetail extends StatelessWidget{
  const TodoDetail({super.key});

  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
     final idx = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(appBar: AppBar(title: Text('Todo $idx'),),
      body: Padding(padding: const EdgeInsets.all(16),child: Text('A description of what needs to be done for Todo $idx'))
    );
  }

}