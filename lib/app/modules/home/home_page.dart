import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
    store.init();
  }

  @override
  void dispose() {
    Modular.dispose<HomeStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desafio Flutter com API'),
      ),
      body: Center(
        child: Observer(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              store.isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      store.displayedUserData,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (store.isInit) {
                    setState(() {
                      store.reset();
                    });
                  } else {
                    store.incrementCounterAndFetchUser();
                  }
                },
                child: Text(store.textButton),
              ),
            ],
          );
        }),
      ),
    );
  }
}
