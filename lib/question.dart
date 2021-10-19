class Question{
  String category;
  String type;
  String difficulty;
  String question;
  String correct_answer;
  List<String> incorrect_answers;

  Question({required this.category, required this.type, required this.difficulty, required this.question, required this.correct_answer, required this.incorrect_answers});

  Question.fromJson(Map<String, dynamic> json)
    : category = json['category'],
    type = json['type'],
    difficulty = json['difficulty'],
    question = json['question'],
    correct_answer = json['correct_answer'],
    incorrect_answers = json['incorrect_answers'];
}