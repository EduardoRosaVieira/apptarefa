class Tarefa {
  final int? id;
  final String  nome;
  final String descricao;
  final String dataInicio;
  final String dataFim;
  Tarefa({this.id,required this.nome, required this.descricao,required this.dataInicio,required this.dataFim});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'dataInicio': dataInicio,
      'dataFim': dataFim,


    };
  }
}