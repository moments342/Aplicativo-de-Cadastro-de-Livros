import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'data/models/livro.dart';
import 'data/repositories/livro_repository.dart';
import 'pages/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(LivroAdapter().typeId)) {
    Hive.registerAdapter(LivroAdapter());
  }
  await Hive.openBox<Livro>('livros');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Livros',
      theme: AppTheme.theme,
      home: HomePage(repositorio: LivroRepository()),
      debugShowCheckedModeBanner: false,
    );
  }
}
