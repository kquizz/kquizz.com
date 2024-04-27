function setup() {
  x_max = windowWidth * .95 * .66;
  y_max = windowHeight * .95 * .66;

  createCanvas(x_max, y_max);

  x = 50;
  y = 50;
  vel = 2

  x_vel = vel;
  y_vel = vel;

  counter = 0
  color_functions = [
    function () { fill(255, 255, 255); },
    function () { fill(255, 255, 0); },
    function () { fill(255, 0, 255); },
    function () { fill(255, 0, 0); },
    function () { fill(0, 255, 255); },
    function () { fill(0, 255, 0); },
    function () { fill(0, 0, 255); }
  ];

  color_functions[0]();
}

function draw() {
  background(0);
  textSize(32);
  text('kquizz', x, y);

  progress();
}

function progress() {
  x = x + x_vel;
  y = y + y_vel;

  if (y >= height - 4 || y <= 24) {
    next_color();
    y_vel = -1 * y_vel;
  }
  if (x >= width - 91 || x <= 0) {
    next_color();
    x_vel = -1 * x_vel;
  }
}


function next_color() {
  counter = counter + 1
  if (counter >= color_functions.length) {
    counter = 0
  }
  color_functions[counter]();
}

function windowResized() {
  resizeCanvas(x_max, y_max);
}