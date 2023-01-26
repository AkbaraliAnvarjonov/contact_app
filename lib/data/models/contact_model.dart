class ContactFields {
  static String id = "id";
  static String name = "name";
  static String date = "date";
  static String number = "number";
}

class ContactModel {
  final int? id;
  final String name;
  final String date;
  final String number;

  ContactModel({
    this.id,
    required this.date,
    required this.name,
    required this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date,
      'number': number,
    };
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? -1,
      date: json['date'] ?? '',
      name: json['name'] ?? '',
      number: json['number'] ?? '',
    );
  }

  ContactModel copyWith({
    int? id,
    String? date,
    String? name,
    String? number,
  }) =>
      ContactModel(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        number: number ?? this.number,
      );
}
