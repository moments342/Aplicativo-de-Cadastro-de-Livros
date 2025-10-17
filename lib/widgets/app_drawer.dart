import 'package:flutter/material.dart';
import '../pages/cadastro/cadastro_page.dart';
import '../data/repositories/livro_repository.dart';

class AppDrawer extends StatelessWidget {
  final LivroRepository repositorio;

  const AppDrawer({super.key, required this.repositorio});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
              child: const Text(
                'Catálogo de Livros',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_add_outlined),
              title: const Text('Cadastro'),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CadastroPage(repositorio: repositorio),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
