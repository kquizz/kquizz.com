class Snake {
  constructor(length, direction, x, y, speed) {
    this.length = length;
    this.direction = direction;
    this.tail = [];
    this.speed = speed

    for (let i = 0; i < this.length; i++) {
      this.tail.unshift([x + i * this.length, y]);
    }
  }

  head() {
    return this.tail[0];
  }

  checkSnakeCollision() {
    return this.head()[0] > width ||
      this.head()[0] < 0 ||
      this.head()[1] > height ||
      this.head()[1] < 0 ||
      this.tail.slice(1).some(([x, y]) => x === this.head()[0] && y === this.head()[1]);
  }

  draw() {
    for (let i = 0; i < this.length - 1; i++) {
      line(this.tail[i][0], this.tail[i][1], this.tail[i + 1][0], this.tail[i + 1][1]);
    }
  }

  updateCoordinates() {
    switch (this.direction) {
      case 'right':
        this.tail.unshift([this.tail[0][0] + this.speed, this.tail[0][1]]);
        break;
      case 'up':
        this.tail.unshift([this.tail[0][0], this.tail[0][1] - this.speed]);
        break;
      case 'left':
        this.tail.unshift([this.tail[0][0] - this.speed, this.tail[0][1]]);
        break;
      case 'down':
        this.tail.unshift([this.tail[0][0], this.tail[0][1] + this.speed]);
        break;
    }
    if (this.tail.length > this.length) {
      this.tail.splice(this.length);
    }
  }

  checkGameStatus() {
    if (this.checkSnakeCollision()) {
      noLoop();
      const scoreVal = parseInt(scoreElem.html().substring(8));
      scoreElem.html('Game ended! Your score was : ' + scoreVal);
    }
  }

  checkForFruit(fruit) {
    if (this.head()[0] == fruit.x && this.head()[1] == fruit.y) {
      const prevScore = parseInt(scoreElem.html().substring(8));
      scoreElem.html('Score = ' + (prevScore + 1));
      this.tail.unshift([this.head()[0], this.head()[1]]);
      this.length++;
      fruit.changeLocation();
    }
  }

}

class Fruit {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  //This is from the original Snake code, to ensure the fruit lines up with where the snake will be
  changeLocation() {
    this.x = floor(random(10, (width - 100) / 10)) * 10;
    this.y = floor(random(10, (height - 100) / 10)) * 10;
  }

  draw() {
    point(this.x, this.y);
  }
}

let snake;
let fruit;
let scoreElem;

function setup() {
  snake = new Snake(10, 'right', 0, 250, 10)
  fruit = new Fruit(0, 0);

  scoreElem = createDiv('Score = 0');
  scoreElem.position(20, 30);
  scoreElem.id = 'score';
  scoreElem.style('color', 'white');

  x_max = windowWidth * .95 * .66;
  y_max = windowHeight * .95 * .66;

  createCanvas(x_max, y_max);
  frameRate(15);
  stroke(255);
  strokeWeight(10);
  fruit.changeLocation();
}

function draw() {
  background(0);
  snake.updateCoordinates();
  snake.checkGameStatus();
  snake.checkForFruit(fruit);

  snake.draw();
  fruit.draw();
}


function keyPressed() {
  switch (keyCode) {
    case 74:
      if (snake.direction !== 'right') {
        snake.direction = 'left';
      }
      break;
    case 76:
      if (snake.direction !== 'left') {
        snake.direction = 'right';
      }
      break;
    case 73:
      if (snake.direction !== 'down') {
        snake.direction = 'up';
      }
      break;
    case 75:
      if (snake.direction !== 'up') {
        snake.direction = 'down';
      }
      break;
  }
}