class CategoriesModel{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel{
  int? currentPage;
  List<DataModel> data=[];
  CategoriesDataModel.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    data = List.from(json['data']).map((e)=>DataModel.fromJson(e)).toList();
    // json['data']?.forEatch((element) {
    // data.add(DataModel.fromJson(element));
    // });
  }
}

class DataModel{
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}