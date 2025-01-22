class Notebook {
  final int id;
  final String name;
  final String grade;
  final String section;
  final String course;
  final String logoUrl;
  final int subject;
  final String phone;
  final String token;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // Constructor
  Notebook({
    required this.id,
    required this.name,
    required this.grade,
    required this.section,
    required this.course,
    required this.logoUrl,
    required this.subject,
    required this.phone,
    required this.token,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to parse from JSON
  factory Notebook.fromJson(Map<String, dynamic> json) {
    return Notebook(
      id: json['id'] ?? 0,
      name: json['namenot'] ?? '',
      grade: json['grade'] ?? '',
      section: json['section'] ?? '',
      course: json['course'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      subject: json['Subject'] ?? 0,
      phone: json['phone'] ?? '',
      token: json['token'] ?? '',
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
    );
  }

  // Convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'namenot': name,
      'grade': grade,
      'section': section,
      'course': course,
      'logoUrl': logoUrl,
      'Subject': subject,
      'phone': phone,
      'token': token,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
