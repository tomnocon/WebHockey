/* @pjs preload="images/board.png"; */

interface GameEvents {
  void goal(int playerId);
}

void bindGameEvents(GameEvents gameEventImpl){
  gameEvents = gameEventImpl;
}

float ball_x;
float ball_y;
float ball_dir = 1;
float ball_size = 8;  // Radius
float dy = 0;  // Direction

// Global variables for the paddle
int paddle_width = 5;
int paddle_height = 60;
int paddle1_pos; // paddle 1 destination
int paddle1_cur_pos; // current paddle 1 position
int paddle2_pos; // paddle 2 destination
int paddle2_cur_pos; // current paddle 2 position
int goal_width = 15;
int goal_height = 190;
int goal_y;

int dist_wall = 30;
int delay = 6;
bool gameStarted = false;
PImage board;
GameEvents gameEvents;

void setup()
{
  frameRate(60);
  board = loadImage("images/board.png");
  size(1000, 670);
  rectMode(CENTER_RADIUS);
  ellipseMode(CENTER_RADIUS);
  noStroke();
  smooth();
  ball_y = height/2;
  ball_x = width/2;
  paddle1_pos = height/2;
  paddle1_cur_pos = paddle1_pos;
  paddle2_pos = paddle1_pos;
  paddle2_cur_pos = paddle1_pos;
  goal_y = height/2;
}

void draw()
{
  background(board);

  // Constrain paddle to screen
  float paddle1_y = constrain(paddle1_cur_pos, paddle_height, height-paddle_height);
  float paddle2_y = constrain(paddle2_cur_pos, paddle_height, height-paddle_height);

  if(gameStarted)
  {
    ball_x += ball_dir * 8.0;
    ball_y += dy;
    if(ball_x > width+ball_size) {
      ball_x = width/2;
      ball_y = height/2;
      dy = 0;
      }

    float p1y = width-dist_wall-paddle_width-ball_size;
    float p2y = dist_wall+paddle_width+ball_size;

    if(ball_x < ball_size && ball_dir == -1){ // If ball hits left wall
      if(ball_y < goal_y + goal_height && ball_y > goal_y - goal_height){ // If ball in goal 1
        goal(1);
      }else{ // reverse direction
        ball_dir *= -1;
      }
    }else if(ball_x > width-ball_size && ball_dir == 1){ // If ball hits right wall
      if(ball_y < goal_y + goal_height && ball_y > goal_y - goal_height){ // If ball in goal 2
        goal(2);
      }else{ // reverse direction
        ball_dir *= -1;
      }
    }else if(ball_y > height-ball_size){ // If the ball is touching top or bottom edge, reverse direction
      dy = dy * -1;
    }else if(ball_y < ball_size){
      dy = dy * -1;
    }else if(ball_x > p1y && ball_y > paddle1_y - paddle_height - ball_size
       && ball_y < paddle1_y + paddle_height + ball_size) {  // If the ball is touching the paddle

      ball_dir *= -1;
      if(paddle1_pos != paddle1_cur_pos) {
        dy = (paddle1_pos-paddle1_cur_pos)/2.0;
        if(dy >  5) { dy =  5; }
        if(dy < -5) { dy = -5; }
      }
    }else if(ball_x < p2y && ball_y > paddle2_y - paddle_height - ball_size
         && ball_y < paddle2_y + paddle_height + ball_size) {

      ball_dir *= -1;
      if(paddle2_pos != paddle2_cur_pos) {
        dy = (paddle2_pos-paddle2_cur_pos)/2.0;
        if(dy >  5) { dy =  5; }
        if(dy < -5) { dy = -5; }
      }
    }
  }

  paddle1_cur_pos += (paddle1_pos-paddle1_cur_pos)/delay;
  paddle2_cur_pos += (paddle2_pos-paddle2_cur_pos)/delay;

  // Draw ball
  fill(10,10,10);
  ellipse(ball_x, ball_y, ball_size, ball_size);

  // Draw the goal 1
  fill(255);
  rect(0, goal_y, goal_width, goal_height);

  // Draw the goal 2
  fill(255);
  rect(width, goal_y, goal_width, goal_height);

  // Draw the paddle 1
  fill(10,10,10);
  rect(width-dist_wall, paddle1_y, paddle_width, paddle_height);

  // Draw the paddle 2
  fill(10,10,10);
  rect(dist_wall, paddle2_y, paddle_width, paddle_height);
}

void goal(int playerId)
{
    if(gameEvents != null){
      gameEvents.goal(playerId);
    }
    gameStarted = false;
    ball_y = height/2;
    ball_x = width/2;
}

void movePaddle1(int direction) {
  int paddle_move = paddle1_cur_pos + direction;
  if(paddle_move > 0 && paddle_move < height)
  {
    paddle1_pos = paddle_move;
  }
}

void movePaddle2(int direction) {
  int paddle_move = paddle2_cur_pos + direction;
  if(paddle_move > 0 && paddle_move < height)
  {
    paddle2_pos = paddle_move;
  }
}

void mouseClicked() {
  gameStarted = true;
}