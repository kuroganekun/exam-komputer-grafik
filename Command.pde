class Command {

  private static final int MOVE  = 0;
  private static final int LEFT  = 1;
  private static final int RIGHT = 2;

  int type;
  String name;

  Command(int type, String name) {

    this.type = type;
    this.name = name;
  }
}
