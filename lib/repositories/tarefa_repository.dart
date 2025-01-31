import 'package:sqflite/sqflite.dart';
import '../../core/database_helper.dart';
import '../data/models/tarefa.dart';


class TarefaRepository {
  Future<void> insertTarefa(Tarefa tarefa) async {
    final db = await DatabaseHelper.initDb();
    await db.insert(
      'tarefa',
      tarefa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Tarefa>> gettarefas() async {
    final db = await DatabaseHelper.initDb();
    final List<Map<String, Object?>> tarefasMaps = await db.query('tarefa');
    return tarefasMaps.map((map) {
      return Tarefa(
          id: map['id'] as int?,
          nome: map['nome'] as String,
          descricao: map['descricao'] as String,
          dataInicio: map['dataInicio'] as String,
          dataFim: map['dataFim'] as String,
      );}).toList();

  }

  Future<void> updatetarefa(Tarefa tarefa) async {
    final db = await DatabaseHelper.initDb();
    await db.update(
      'tarefa',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  Future<void> deletetarefa(int id) async {
    final db = await DatabaseHelper.initDb();
    await db.delete(
      'tarefa',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
