import 'package:flutter/material.dart';

void main()=> runApp(MainTab());

class MainTab extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('appbar sample'),
            // bottom: TabBar(tabs: choices.map((choice) =>  Tab(
            //     text: choice.title,
            //   icon: Icon(choice.icon),
            // )).toList(),
            //   isScrollable: true,
            // ),
          ),
          body: TabBarView(
            children:
            choices.map((choice) => Padding(padding: const EdgeInsets.all(16),child: ChoiceCard(choice: choice,),) ).toList()
          ),
        ),
      ),
    );
  }

}

class Choice {
  const Choice({ required this.title, required this.icon });
  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: '首页', icon: Icons.home),
  Choice(title: '消息', icon: Icons.message),
  Choice(title: '我的', icon: Icons.person),
];

class ChoiceCard extends StatelessWidget{
  
  Choice choice;
  ChoiceCard({super.key,required this.choice});
  
  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.displaySmall;
    return Card(
        color: Colors.white,
      child: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Icon(choice.icon, size: 128.0, color: textStyle?.color),
           Text(choice.title, style: textStyle),
        ],
      )),
      );
  }
  
}

