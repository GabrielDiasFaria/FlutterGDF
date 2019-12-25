class EmpresaModel{
  int _id;
  String _descricao;

  EmpresaModel(this._id, this._descricao);

  int get id => _id;
  set id(int value){
    _id = value;
  }

  String get descricao => _descricao;
  set descricao(String value){
    _descricao = value;
  }

}