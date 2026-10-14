abstract class Menu {
  abstract void render();
  abstract void behaviour();
  abstract void process();
  
  protected void update(){
    System.err.println("NOT IMPLEMENTED");
  }
  
  protected void setState(STATE param){
    if(!param.equals(null)) currentState = param;
    System.out.println("State diganti menjadi "+ currentState);
  }
  
  protected STATE getState(){
    return currentState;
  }
  
}

class MainMenu extends Menu {
  
  @Override
  void render(){
    if(!currentState.equals(STATE.MENU)) return;
    
    drawButton((width/4) + (width/8), height/2, width/4, height/8, "START GAME", 36, TEXT_COLOR, ACCENT);
    
    textAlign(CENTER, CENTER);

    fill(ACCENT);
    textSize(58);
    text("CODE RUNNER", width / 2, 180);
  
    fill(TEXT_COLOR);
    textSize(22);
    text("Belajar algoritma melalui permainan", width / 2, 245);
  
    // Description
    fill(MUTED_COLOR);
    textSize(16);
  
    text(
      "Susun instruksi untuk membantu robot mencapai target.",
      width / 2,
      310
      );
  
    text(
      "Gunakan MOVE, TURN LEFT, dan TURN RIGHT.",
      width / 2,
      340
      );
  
    // Start button
    //drawButton(
    //  width / 2 - 120,
    //  410,
    //  240,
    //  70,
    //  "START GAME",
    //  ACCENT
    //  );
      
    //drawButton(width/3, height/3, width/4, height/5, "MAIN MENU", 70, TEXT_COLOR, ACCENT);
  
    //fill(MUTED_COLOR);
    //textSize(14);
    //text(
    //  "PoC Educational Game — Processing Java",
    //  width / 2,
    //  620
    //  );
  }
  
  @Override
  void behaviour(){
    if(!currentState.equals(STATE.MENU)) return;
    
    this.setState(STATE.STAGE);
    menu = new StageMenu();
  }
  
  @Override
  void update(){
    this.process();
  }
  
  @Override
  void process(){
    if(!currentState.equals(STATE.MENU)) return; // Validasi status ketika di menu
    
    if(!mousePressed) return; // validasi mouse benar-benar diklik
    boolean isPressed = mouseX >= width/3 && mouseX <= ((width/3) + (width/4)) && mouseY >= height/3 && mouseY <= ((height/3) + (height/5));
    if(isPressed) this.behaviour();
  }
}

class StageMenu extends Menu {
  
  @Override
  void render(){
    if(!currentState.equals(STATE.STAGE)) return;
    
    drawButton(width/3, height/3, width/4, height/5, "STAGE MENU", 36, TEXT_COLOR, ACCENT);
  }
  
  @Override
  void behaviour(){
    System.out.println("Perilaku dari Stage");
  }
  
  @Override
  void update(){
    //this.setState(STATE.STAGE);
    System.out.println("Stage!");
    fill(255);
    textSize(100);
    text("TEST", 100, 100);
  }
  
  @Override
  void process(){
  }
}

class GameMenu extends Menu {
  
  @Override
  void render(){
    System.out.println("Gameplay");
  }
  
  @Override
  void behaviour(){
    System.out.println("Perilaku dari Game");
  }
  
  @Override
  void update(){
    this.setState(STATE.GAME);
  }
  
  @Override
  void process(){
  }
}

class ResultMenu extends Menu {
  
  @Override
  void render(){
    System.out.println("Main Menu");
  }
  
  @Override
  void behaviour(){
    System.out.println("Perilaku dari Result");
  }
  
  @Override
  void update(){
    this.setState(STATE.RESULT);
  }
  
  @Override
  void process(){
  }
}
