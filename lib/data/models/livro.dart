import 'package:hive/hive.dart';

class Livro {
  String titulo;
  String autor;
  int anoPublicacao;
  String editora;

  Livro({
    required this.titulo,
    required this.autor,
    required this.anoPublicacao,
    required this.editora,
  });
}

class LivroAdapter extends TypeAdapter<Livro> {
  @override
  final int typeId = 1;

  @override
  Livro read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Livro(
      titulo: fields[0] as String,
      autor: fields[1] as String,
      anoPublicacao: fields[2] as int,
      editora: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Livro obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.titulo)
      ..writeByte(1)
      ..write(obj.autor)
      ..writeByte(2)
      ..write(obj.anoPublicacao)
      ..writeByte(3)
      ..write(obj.editora);
  }
}
