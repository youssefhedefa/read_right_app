class UserModel{

  final String id;
  final String email;
  final String name;
  final String image;
  final String audio;
  final List<dynamic> myBooks;
  final int totalWords;
  final int wrongWords;
  final int correctWords;

  UserModel({required this.id, required this.email, required this.name, required this.image, required this.audio, required this.totalWords, required this.wrongWords, required this.correctWords,required this.myBooks});

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
      audio: map['audio'],
      totalWords: map['total_words'],
      wrongWords: map['wrong_words'],
      correctWords: map['correct_words'],
      myBooks: map['saved_books'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'email': email,
      'name': name,
      'image': image,
      'audio': audio,
      'total_words': totalWords,
      'wrong_words': wrongWords,
      'correct_words': correctWords,
      'saved_books': myBooks,
    };
  }


}