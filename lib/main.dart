import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Achat> courses = [
    Achat('tomates'),
    Achat('pommes'),
    Achat('poires'),
    Achat('bananes'),
    Achat('pommes de terre'),
    Achat('carottes'),
    Achat('courgettes'),
    Achat('poivrons'),
    Achat('salade'),
    Achat('choux'),
    Achat('oignons'),
    Achat('ail'),
    Achat('pâtes'),
    Achat('riz'),
    Achat('lentilles'),
    Achat('haricots'),
    Achat('pois chiches'),
  ];

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    print(orientation);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: (orientation == Orientation.portrait)
            ?
            // ListView.builder(
            //     itemBuilder: (BuildContext context, int index) {
            //       final item = courses[index];
            //       return itemToDisplay(item);
            //     },
            //     itemCount: courses.length)
            ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                      color: Colors.indigoAccent,
                    ),
                itemBuilder: (BuildContext context, int index) {
                  final item = courses[index];
                  return Dismissible(
                    background: Container(
                      color: Colors.redAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [Text('Supprimer'), Icon(Icons.delete)],
                      ),
                    ),
                    key: Key(item.nom),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      // ignore: avoid_print
                      print(direction);
                      setState(() {
                        courses.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('${item.nom} supprimé'),
                          action: SnackBarAction(
                              label: 'Annuler',
                              onPressed: () {
                                setState(() {
                                  courses.insert(index, item);
                                });
                              })));
                    },
                    child: ListTile(
                      title: Text(item.nom),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              item.toggle();
                            });
                          },
                          icon: Icon(item.achete
                              ? Icons.check_box
                              : Icons.check_box_outline_blank)),
                      leading: Text(index.toString()),
                      onTap: () {
                        // ignore: avoid_print
                        print('$item tapped');
                      },
                    ),
                  );
                },
                itemCount: courses.length)
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          courses[index].toggle();
                        });
                      },
                      child: Card(
                          color: courses[index].achete
                              ? Colors.green[500]
                              : Colors.redAccent,
                          child: Center(child: Text(courses[index].nom))),
                    ),
                itemCount: courses.length));
  }

  List<Widget> itemWidget() {
    List<Widget> items = [];
    for (var item in courses) {
      items.add(Row(
        children: [
          Text(item.nom),
          const Spacer(),
          const Icon(Icons.check_box_outline_blank)
        ],
      ));
    }
    return items;
  }

  Widget itemToDisplay(String item) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(item),
            const Spacer(),
            const Icon(Icons.check_box_outline_blank)
          ],
        ));
  }
}

class Achat {
  String nom;
  bool achete = false;

  Achat(this.nom);

  void toggle() {
    achete = !achete;
  }
}
