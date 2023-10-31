import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class happyHourList extends StatelessWidget {
  const happyHourList({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HappyHourList(title: 'Happier Hour'),
    );
  }
}

class HappyHourList extends StatefulWidget {
  const HappyHourList({super.key, required this.title});

  final String title;

  @override
  State<HappyHourList> createState() => _HappyHourListState();
}

class _HappyHourListState extends State<HappyHourList> {
  final _future = Supabase.instance.client
      .from('happy_hour')
      .select<List<Map<String, dynamic>>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            // process returned response:
            final jsonbody = snapshot.data!;
            return ListView.builder(
              itemCount: jsonbody.length,
              itemBuilder: ((context, index) {
                return ExpansionTile(
                  title: Text(jsonbody[index]['name']),
                  subtitle: Text(jsonbody[index]['address']),
                  children: const <Widget>[
                    ListTile(title: Text('Additional info')),
                  ],
                );
              }),
            );
          }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
