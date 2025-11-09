class User {
  int? id;
  String? name;
  String? telepon;
  String? deskripsi;
  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['telepon'] = telepon!;
    mapping['deskripsi'] = deskripsi!;
    return mapping;
  }
}