import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() => runApp(const NamerPage());

class NamerPage extends StatelessWidget {
  const NamerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
          title: 'namer app',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          ),
          home: MyHomePage()),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favorites = <WordPair>[];

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),

        // ↓ Make the following change.
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}

class NamerMain extends StatefulWidget {
  const NamerMain({super.key});

  @override
  createState() => NameMainState();
}

class NameMainState extends State<NamerMain> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon = (appState.favorites.contains(pair)
        ? Icons.favorite
        : Icons.favorite_border);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: const Text('Like')),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                    onPressed: () {
                      appState.getNext();
                    },
                    child: const Text('Next')),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
   createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage>{

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return ListView(children: [
          Padding(padding: EdgeInsets.all(16),child:
          Text('you have ${appState.favorites.length} favorites'),),
          for(var pair in appState.favorites)
            ListTile(
              leading: const Icon(Icons.favorite),
              title: Text(pair.asPascalCase),
            ),
        ],

    );
  }

}



class MyHomePageState extends State<MyHomePage> {
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    Widget selectedWidget;
    switch (_selected) {
      case 0:
        selectedWidget = NamerMain();
        break;
      case 1:
        selectedWidget = FavoritePage();
        break;
      default:
        throw UnimplementedError('no widget implemented');
    }
        return LayoutBuilder(builder: (context,constraint){
          return  Scaffold(
              body: Row(
                children: [
                  SafeArea(
                      child: NavigationRail(
                        extended: constraint.maxWidth>=600,
                        destinations: [
                          NavigationRailDestination(
                              icon: Icon(Icons.home), label: Text('Home')),
                          NavigationRailDestination(
                              icon: Icon(Icons.favorite), label: Text('Favorite'))
                        ],
                        selectedIndex: _selected,
                        onDestinationSelected: (index) {
                          setState(() {
                            _selected = index;
                          });
                        },
                      )),
                  Expanded(
                      child: Container(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: selectedWidget, // ← Here.
                      ))
                ],
              ));
        });

  }
}

class MyHomePage extends StatefulWidget {
  @override
  createState() => MyHomePageState();
}
