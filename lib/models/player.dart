class Player {
  final String name;
  final String vote;

  Player({
    required this.name,
    required this.vote,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'vote': vote,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'] as String,
      vote: map['vote'] as String,
    );
  }

  @override
  String toString() {
    return 'Player{name: $name, vote: $vote}';
  }
}
