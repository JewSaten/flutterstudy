
import 'package:flutter/material.dart';
import 'dart:developer' as developer;


void main() => runApp(MaterialApp(title: 'pop return result',
  initialRoute: APage.routeName,
  routes: {
  APage.routeName: (context) => APage(),
    BPage.routeName: (context) => BPage()
  }
));


class APage extends StatefulWidget {
  static const routeName = '/';

  const APage({super.key});

  @override createState() => APageState();

}

class APageState extends State<APage>{

  @override
  Widget build(BuildContext context) {
      return
        Scaffold(appBar: AppBar(title: Text('APage'),),body:  Center(
          child: ElevatedButton(
            onPressed: (){
                pushB(context);
            },
            child: Text('start select option'),
          ),
        ));
  }

  Future<void> pushB(BuildContext context) async{
    final result = await Navigator.pushNamed(context, BPage.routeName);
    developer.log('$result');

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}


class BPage extends StatelessWidget {
  static const routeName = '/b';

  const BPage({super.key});

  @override
  Widget build(BuildContext context) {
     return
       Scaffold(appBar: AppBar(title: Text('BPage')),body: Center(child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           ElevatedButton(onPressed: (){
             Navigator.pop(context,'Yes');
           }, child: Text('Select Yes')),

           ElevatedButton(onPressed: (){
             Navigator.pop(context,'No');
           }, child: Text('Select No'))
         ],
       )));
  }


}