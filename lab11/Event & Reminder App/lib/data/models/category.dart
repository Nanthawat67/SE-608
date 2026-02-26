class Category {
  int? id;
  String name;
  String colorHex;
  String iconKey;

  Category({
    this.id,
    required this.name,
    required this.colorHex,
    required this.iconKey,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'color_hex': colorHex,
        'icon_key': iconKey,
      };

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      colorHex: map['color_hex'],
      iconKey: map['icon_key'],
    );
  }
}