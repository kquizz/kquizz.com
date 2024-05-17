class Text {
  constructor(x, y, vel, text, colorController) {
    this.x = x;
    this.y = y;
    this.x_vel = vel;
    this.y_vel = vel;
    this.text = text;
    this.colorController = colorController
  }

  progress() {
    this.x = this.x + this.x_vel;
    this.y = this.y + this.y_vel;

    if (this.y >= height - 4 || this.y <= 24) {
      this.colorController.nextColor();
      this.y_vel = -1 * this.y_vel;
    }
    if (this.x >= width - 91 || this.x <= 0) {
      this.colorController.nextColor();
      this.x_vel = -1 * this.x_vel;
    }
  }
}

class ColorController {
  constructor(colorList) {
    this.functions = colorList.map(function (color) { return function () { fill(color[0], color[1], color[2]); } });
    this.counter = 0;
  }

  setColor() {
    this.functions[this.counter]();
  }
  nextColor() {
    this.incCounter();
    this.setColor();
  }

  incCounter() {
    this.counter = this.counter + 1
    if (this.counter >= this.functions.length) {
      this.counter = 0
    }
  }
}

let myText;


function setup() {
  x_max = windowWidth;
  y_max = windowHeight * .7;

  var canvas = createCanvas(x_max, y_max);
  canvas.parent("kquizz_bounce");


  let colorController = new ColorController([
    [0, 19, 164],
    [0, 167, 142],
    [0, 100, 143],
    [46, 149, 114],
    [146, 102, 0],
    [143, 0, 29],
    [0, 167, 142]]);

  myText = new Text(50, 50, 2, "kquizz", colorController);

  myText.colorController.setColor();
}

function draw() {
  background(0);
  textSize(32);
  text(myText.text, myText.x, myText.y);

  myText.progress();
}

function windowResized() {
  resizeCanvas(x_max, y_max);
}