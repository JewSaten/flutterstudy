import 'package:flutter/material.dart';
import 'dart:developer' as developer;

void main() => runApp(const MyListView());

class MyListView extends StatelessWidget{
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'listview demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ListViewWidget(),
      );
  }
}

class ListViewWidget extends StatefulWidget{
  const ListViewWidget({super.key});

  @override
  createState() => ListViewState();

}

class ListViewState extends State<ListViewWidget>{

  List<Widget> _buildRows(){
    List<Widget> widgets = [];
    for(int i =0;i<100;i++){
      widgets.add(
        GestureDetector(
          onTap: onItemClick,
            child: Padding(padding: const EdgeInsets.all(10),child: Text('row $i'))
        ),
      );
    }
    return widgets;
  }

  void onItemClick(){
    developer.log('row tapped');
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('listview'),),
        ),
        body: ListView(children: _buildRows(),),
      );
  }

}

class ListViewBuilderState extends State<ListViewWidget>{
  List<Widget> widgets = [];
  @override
  void initState() {
    super.initState();
    for(int i =0;i<100;i++){
      widgets.add(getRow(i));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('listview builder'),
      ),
      body: ListView.builder(
          itemCount : widgets.length,
          itemBuilder: (context,position) {
            return getRow(position);
          }
      ),
    );
  }

  Widget getRow(int i){
    return GestureDetector(
      onTap: () {
        setState(() {
          widgets.add(getRow(widgets.length));
          developer.log('add row');
        });
      },

      child: Padding( padding: const EdgeInsets.all(10),child: Text(
          'row builder $i',style:const TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold),
      ),)
    );
  }

}



