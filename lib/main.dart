import 'package:flutter/material.dart';
import 'package:opal_app/sign_in_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final HttpLink httpLink = HttpLink("https://app.opal.com.br/graphql/");
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(link: httpLink, cache: GraphQLCache()),
  );
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  MyApp({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CreateUserScreen(),
      ),
    );
  }
}


