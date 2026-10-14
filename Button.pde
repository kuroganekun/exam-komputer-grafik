void drawButton(int x, int y, int w, int h, String label, int labelSize, color labelColor, color buttonColor) {

  boolean hover = mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;

  if (hover) {
    fill(min(red(buttonColor) + 30, 255), min(green(buttonColor) + 30, 255), min(blue(buttonColor) + 30, 255));
  } else {
    fill(buttonColor);
  }

  noStroke();
  rect(x, y, w, h, w * 0.05);

  fill(labelColor);
  textAlign(CENTER, CENTER);
  textSize(labelSize);

  text(label, x + w / 2, y + h / 2);
}
