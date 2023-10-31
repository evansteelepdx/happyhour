import 'components/components.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'api/api_key.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://supabase.evansteele.net', anonKey: supabaseKey);

  runApp(const HappyHourHome());
}

class HappyHourHome extends StatelessWidget {
  const HappyHourHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Happy Hours', icon: Icon(Icons.list)),
                Tab(text: 'Favorites', icon: Icon(Icons.star)),
                Tab(text: 'Map', icon: Icon(Icons.map)),
              ],
            ),
            title: const Text('Happier Hour'),
          ),
          body: const TabBarView(
            children: [
              happyHourList(),
              Text('Curated list with more info'),
              Text('Map with geolocation data'),
            ],
          ),
        ),
      ),
    );
  }
}
