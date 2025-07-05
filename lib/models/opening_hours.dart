class OpeningHours {
  final String from;
  final String until;
  final List<int> occupancies;

  OpeningHours({required this.from, required this.until, required this.occupancies});

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      from: json['from'],
      until: json['until'],
      occupancies: List<int>.from(json['occupancies']),
    );
  }
}