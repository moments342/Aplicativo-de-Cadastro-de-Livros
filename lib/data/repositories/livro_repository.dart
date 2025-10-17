import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/livro.dart';

class LivroRepository {
  Box<Livro> get _box => Hive.box<Livro>('livros');

  ValueListenable<Box<Livro>> listenable() => _box.listenable();

  List<Livro> listarTodos() => _box.values.toList();

  Future<void> adicionar(Livro livro) async {
    await _box.add(livro);
  }

  Future<void> remover(int indice) async {
    await _box.deleteAt(indice);
  }

  Future<void> atualizar(int indice, Livro livro) async {
    await _box.putAt(indice, livro);
  }

  Livro? obterPorIndice(int indice) {
    if (indice < 0 || indice >= _box.length) return null;
    return _box.getAt(indice);
  }
}
