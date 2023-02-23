import 'package:flutter/material.dart';

void main() => runApp(const NamedPageRoute());


class NamedPageRoute extends StatelessWidget{
  const NamedPageRoute({super.key});


  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       title: 'named page route',
       initialRoute: FirstRoute.routeName,
       routes: {
         FirstRoute.routeName: (context) => const FirstRoute(),
         SecondRoute.routeName: (context) => const SecondRoute()
       });
  }

}

class MyMaterialPageRoute extends StatelessWidget{
  const MyMaterialPageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'material page route',home: FirstRoute()
    );
  }

}

class FirstRoute extends StatelessWidget{
  const FirstRoute({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const SecondRoute()));
         
         // Navigator.push(context, MaterialPageRoute(builder: (context)=>const SecondRoute(),settings: const RouteSettings(arguments: '路由跳转传参')));
          Navigator.pushNamed(context, SecondRoute.routeName,arguments: '路由跳转传参');
        }, child: Text('open route'),),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget{
  const SecondRoute({super.key});

  static const routeName = '/second';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Route'),
      ),
      body: Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[ ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('go back!')), Text('参数: $args') ],
      )),
    );
  }
}