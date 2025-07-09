abstract class Classes {
  final String name;
  final int attack;
  final int health;
  final int defence;

  Classes(this.name, this.attack, this.health, this.defence);

  String get getName => name;
  int get getAttack => attack;
  int get getDefence => defence;
  int get getHealth => health;
}