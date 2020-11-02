class PlayerManager {
  int score;
  List<int> stack;
  String name;

  PlayerManager(String name, int startScore) {
    this.name = name;
    this.score = startScore;
    this.stack = new List();
  }
}
