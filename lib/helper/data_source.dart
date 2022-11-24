import 'base_network.dart';

class DataSource{
  static DataSource instance = DataSource();
  Future<List<dynamic>> loadHeroes(){
    return BaseNetwork.getList("heroes");
  }
  Future<List<dynamic>> loadVillains(){
    return BaseNetwork.getList("villains");
  }
}