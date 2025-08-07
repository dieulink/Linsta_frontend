class RatingResponse {
  final int id;
  final String userName;
  final int score;
  final String comment;
  final DateTime createdAt;

  RatingResponse({
    required this.userName,
    required this.score,
    required this.comment,
    required this.createdAt,
    required this.id,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      id: json['id'],
      userName: json['userName'],
      score: json['score'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
