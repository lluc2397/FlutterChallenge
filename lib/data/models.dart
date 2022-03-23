final String tableProjects = 'projects';
final String tableStackeholders = 'stackeholders';

class ProjectFields {
  static final List<String> values = [
    /// Add all fields
    id, name, web, img, description, budget, closingDate, isOpened
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String web = 'web';
  static final String description = 'description';
  static final String img = 'img';
  static final String budget = 'budget';
  static final String closingDate = 'closingDate';
  static final String isOpened = 'isOpened';

}

class Project {
  final int? id;
  final String name;
  final String web;
  final String description;
  final String img;
  final double budget;
  final DateTime closingDate;
  final bool isOpened;

  const Project({
    this.id,
    required this.name,
    required this.web,
    required this.description,
    required this.img,
    required this.budget,
    required this.closingDate,
    required this.isOpened,
  });

  Project copy({
    int? id,
    String? name,
    String? web,
    String? description,
    String? img,
    double? budget,
    DateTime? closingDate,
    bool? isOpened,
  }) =>
      Project(
        id: id ?? this.id,
        name: name ?? this.name,
        web: web ?? this.web,
        description: description ?? this.description,
        img: img ?? this.img,
        budget: budget ?? this.budget,
        closingDate: closingDate ?? this.closingDate,
        isOpened: isOpened ?? this.isOpened,
      );

  static Project fromJson(Map<String, Object?> json) => Project(
        id: json[ProjectFields.id] as int?,
        name: json[ProjectFields.name] as String,
        web: json[ProjectFields.web] as String,
        description: json[ProjectFields.description] as String,
        img: json[ProjectFields.img] as String,
        budget: json[ProjectFields.budget] as double,
        closingDate: DateTime.parse(json[ProjectFields.closingDate] as String),
        isOpened: json[ProjectFields.isOpened] == 1,
      );

  Map<String, Object?> toJson() => {
        ProjectFields.id: id,
        ProjectFields.name: name,
        ProjectFields.web: web,
        ProjectFields.description: description,
        ProjectFields.img: img,
        ProjectFields.budget: budget,
        ProjectFields.closingDate: closingDate.toIso8601String(),
        ProjectFields.isOpened: isOpened ? 1 : 0,
      };
}


class StackeholderFields {
  static final List<String> values = [
    /// Add all fields
    id, fullName, email, web, projecsFounded, amount,
  ];

  static final String id = '_id';
  static final String fullName = 'fullName';
  static final String email = 'email';
  static final String web = 'web';
  static final String projecsFounded = 'projecsFounded';
  static final String amount = 'amount';
}


class Stackeholder {
  final int? id;
  final String fullName;
  final String email;
  final String web;
  final String projecsFounded;
  final double amount;

  const Stackeholder({
    this.id,
    required this.fullName,
    required this.email,
    required this.web,
    required this.projecsFounded,
    required this.amount,
  });

  Stackeholder copy({
    int? id,
    String? fullName,
    String? email,
    String? web,
    String? projecsFounded,
    double? amount,
  }) =>
      Stackeholder(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        web: web ?? this.web,
        projecsFounded: projecsFounded ?? this.projecsFounded,
        amount: amount ?? this.amount,
      );

  static Stackeholder fromJson(Map<String, Object?> json) => Stackeholder(
        id: json[StackeholderFields.id] as int?,
        fullName: json[StackeholderFields.fullName] as String,
        email: json[StackeholderFields.email] as String,
        web: json[StackeholderFields.web] as String,
        projecsFounded: json[StackeholderFields.projecsFounded] as String,
        amount: json[StackeholderFields.amount] as double,
      );

  Map<String, Object?> toJson() => {
        StackeholderFields.id: id,
        StackeholderFields.fullName: fullName,
        StackeholderFields.email: email,
        StackeholderFields.web: web,
        StackeholderFields.projecsFounded: projecsFounded,
        StackeholderFields.amount: amount,
      };
}