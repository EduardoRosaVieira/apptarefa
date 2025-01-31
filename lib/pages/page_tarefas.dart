import 'package:flutter/material.dart';
import 'package:projeto_1/data/models/tarefa.dart';

class TarefaEditPage extends StatefulWidget {
  final Tarefa tarefa;

  const TarefaEditPage({super.key, required this.tarefa});

  @override
  TarefaEditPage createState() => TarefaEditPage();
}

class TarefaEditPageState extends State<TarefaEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descricaoController = TextEditingController();
  final TarefaViewModel, _viewModel = TarefaViewModel,(TarefaRepository());

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.tarefa.nome;
    _descricaoController.text = widget.tarefa.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  _updateTarefa() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updateTarefa = Tarefa(
        id: widget.tarefa.id,
        nome: _nameController.text,
        descricao: (_descricaoController.text),
      );

      await _viewModel.updateTarefa(updateTarefa);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tarefa atualizado com sucesso!')),
        );
        Navigator.pop(context, updateTarefa); // Retorna a Tarefa atualizado
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edição Tarefa'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Editar Tarefa',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com um nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _descricaoController,
                        decoration: InputDecoration(
                          labelText: 'Idade',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor entre com a idade';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Por favor entre com um número válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: _updateTarefa,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        icon: const Icon(Icons.save, size: 24),
                        label: const Text(
                          'Salvar Alterações',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}