abstract class EntityBase<T>{

  static String collectionName;

  EntityBase.castFromMap(Map<String,dynamic> map);

  String getId();
  void setId(String id);
  Map<String,dynamic> getData();
  // Map<String,dynamic> getNewData();

}