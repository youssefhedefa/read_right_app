class QuestionModel{
  final String question;
  final List<String> options;
  final String answer;
  final String? image;

  QuestionModel({required this.question, required this.options, required this.answer ,this.image});

  factory QuestionModel.fromJson(Map<String, dynamic> json){
    return QuestionModel(
      question: json['question'],
      options: List<String>.from(json['choices']),
      answer: json['answer'],
      image: json['image']
    );
  }

}