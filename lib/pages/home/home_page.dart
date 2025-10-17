import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/livro.dart';
import '../../data/repositories/livro_repository.dart';
import '../../widgets/app_drawer.dart';
import '../cadastro/cadastro_page.dart';

class HomePage extends StatelessWidget {
  final LivroRepository repositorio;

  const HomePage({super.key, required this.repositorio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Livros')),
      drawer: AppDrawer(repositorio: repositorio),
      body: ValueListenableBuilder(
        valueListenable: repositorio.listenable(),
        builder: (context, Box<Livro> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum livro cadastrado. Use o + ou o menu "Cadastro".',
              ),
            );
          }

          return ListView.separated(
            itemCount: box.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final livro = box.getAt(index);
              if (livro == null) return const SizedBox.shrink();

              return ListTile(
                title: Text(livro.titulo),
                subtitle: Text(
                  '${livro.autor} • ${livro.editora} • ${livro.anoPublicacao}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await repositorio.remover(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CadastroPage(repositorio: repositorio),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
