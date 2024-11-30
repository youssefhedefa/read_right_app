class ProfileEntity {
  final String photo;
  final String name;
  final String email;
  final List<dynamic> savedBooks;
  final int totalWords;
  final int correctWords;
  final int wrongWords;


  ProfileEntity({
    required this.photo,
    required this.name,
    required this.email,
    required this.totalWords,
    required this.correctWords,
    required this.wrongWords,
    required this.savedBooks,
  });
}