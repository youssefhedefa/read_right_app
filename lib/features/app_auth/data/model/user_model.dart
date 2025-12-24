class UserModel {
  final String id;
  final String email;
  final String name;
  final String image;
  final String audio;
  final List<dynamic> myBooks;
  final int totalWords;
  final int wrongWords;
  final int correctWords;
  final String gender;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.image,
    required this.audio,
    required this.totalWords,
    required this.wrongWords,
    required this.correctWords,
    required this.myBooks,
    required this.gender,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
      audio: map['audio'],
      totalWords: map['total_words'],
      wrongWords: map['wrong_words'],
      correctWords: map['correct_words'],
      gender: map['gender'] ?? 'male',
      myBooks: map['saved_books'],
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? image,
    String? audio,
    int? totalWords,
    int? wrongWords,
    int? correctWords,
    List<dynamic>? myBooks,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      image: image ?? this.image,
      audio: audio ?? this.audio,
      totalWords: totalWords ?? this.totalWords,
      wrongWords: wrongWords ?? this.wrongWords,
      correctWords: correctWords ?? this.correctWords,
      myBooks: myBooks ?? this.myBooks,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'image': image,
      'audio': audio,
      'total_words': totalWords,
      'wrong_words': wrongWords,
      'gender': gender,
      'correct_words': correctWords,
      'saved_books': myBooks,
    };
  }
}
