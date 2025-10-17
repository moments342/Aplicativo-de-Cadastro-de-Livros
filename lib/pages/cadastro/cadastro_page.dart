import 'package:flutter/material.dart';
import '../../data/models/livro.dart';
import '../../data/repositories/livro_repository.dart';

class CadastroPage extends StatefulWidget {
  final LivroRepository repositorio;
  final int? indexEdicao;
  final Livro? livroExistente;

  const CadastroPage({
    super.key,
    required this.repositorio,
    this.indexEdicao,
    this.livroExistente,
  });

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _tituloCtrl;
  late final TextEditingController _autorCtrl;
  late final TextEditingController _anoCtrl;
  late final TextEditingController _editoraCtrl;

  @override
  void initState() {
    super.initState();
    _tituloCtrl = TextEditingController(
      text: widget.livroExistente?.titulo ?? '',
    );
    _autorCtrl = TextEditingController(
      text: widget.livroExistente?.autor ?? '',
    );
    _anoCtrl = TextEditingController(
      text: widget.livroExistente?.anoPublicacao.toString() ?? '',
    );
    _editoraCtrl = TextEditingController(
      text: widget.livroExistente?.editora ?? '',
    );
  }

  @override
  void dispose() {
    _tituloCtrl.dispose();
    _autorCtrl.dispose();
    _anoCtrl.dispose();
    _editoraCtrl.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState?.validate() != true) return;

    final ano = int.tryParse(_anoCtrl.text.trim()) ?? 0;
    final novoLivro = Livro(
      titulo: _tituloCtrl.text.trim(),
      autor: _autorCtrl.text.trim(),
      anoPublicacao: ano,
      editora: _editoraCtrl.text.trim(),
    );

    if (widget.indexEdicao != null) {
      await widget.repositorio.atualizar(widget.indexEdicao!, novoLivro);
    } else {
      await widget.repositorio.adicionar(novoLivro);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.indexEdicao != null;

    return Scaffold(
      appBar: AppBar(title: Text(editando ? 'Editar Livro' : 'Novo Livro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloCtrl,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Informe o título' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _autorCtrl,
                decoration: const InputDecoration(labelText: 'Autor'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Informe o autor' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _editoraCtrl,
                decoration: const InputDecoration(labelText: 'Editora'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Informe a editora'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _anoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Ano de Publicação',
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Informe o ano';
                  final ano = int.tryParse(v);
                  if (ano == null || ano < 0) return 'Ano inválido';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _salvar,
                      icon: const Icon(Icons.save),
                      label: Text(editando ? 'Salvar alterações' : 'Salvar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
