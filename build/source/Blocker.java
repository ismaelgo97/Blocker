import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Blocker extends PApplet {


Block[] blocks = new Block[60];
Line lit = new Line();
Ball ball = new Ball();

Player player = new Player("Pepe");

boolean gameStarted = false;

int red = color(255, 0, 0);
int green = color(0, 255, 0);
int blue = color(0, 0, 255);
int yellow = color(255, 255, 0);

int initRow = 3;

public void setup(){
    
    
    int a = 0;

    /*

    for (int i = 0; i < 60; i++) {
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, red);
            a++;
        }
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, red);
            a++;
        }
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, red);
            a++;
        }
    }

    */

    for (int i = initRow; i < initRow+2; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, red);
            a++;
        }
    }

    for (int i = initRow+2; i < initRow+4; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, green);
            a++;
        }
    }

    for (int i = initRow+4; i < initRow+6; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, blue);
            a++;
        }
    }
}

public void reset() {
    ball.restore();
    lit.restore();
    gameStarted=false;
}

public void draw(){
    background(0);

    if(gameStarted) {
        ball.update(lit);
        if(ball.isTouchingDown()){
            player.looseLives();
            reset();
        }
    }

    lit.show();

    for (int i = 0; i < blocks.length; i++){
        boolean isAlive = blocks[i].isAlive();
        if (isAlive) {
            blocks[i].show();
            blocks[i].update(ball, player);
        }
    }

    player.show();
    ball.show();

    fill(255);
    text("Created by Ismael and Carlos   (C) 2018", 20, 700);

}

public void keyPressed() {
    if (!player.lost()) {
        if(key==32) {
            reset();
            gameStarted=true;
        }
        if(gameStarted) {
            lit.update(keyCode);
        }
    }
}
class Ball {
    Point centre;
    // float xl, yl;
    private float radius;
    Vector vector;
    float vx = 1;
    float vy = 1;

    Ball(){
        restore();
    }

    private void initPos() {
        radius = 15;
        centre = new Point(500, 640);
    }

    private void initVector() {
        vector = new Vector(random(2, -2), -1);
    }

    public float getRadius() {
        return radius;
    }

    private boolean isTouchingLine(Line line) {
        return this.centre.getX() - radius > line.pos.getX()
            && this.centre.getX() + radius < line.endPos.getX()
            && this.centre.getY() + radius > line.pos.getY();
    }

    private boolean isTouchingTopBorder() {
        return this.centre.getY() == 0;
    }

    private boolean isTouchingSideBorders() {
        return this.centre.getX() == 0
            || this.centre.getX() == width;
    }

    public boolean isTouchingDown() {
        return this.centre.getY() == height;
    }

    public void update() {
        if (isTouchingSideBorders()) {
            vector.changeWayX();
        }
        if (isTouchingTopBorder()) {
            vector.changeWayY();
        }
        centre.move(vector.getX()*vx, vector.getY()*vy);
    }

    public void update(Line line) {
        if (isTouchingLine(line)) {
            vector.changeWayY();
        }
        update();
    }

    public void restore(){
        initPos();
        initVector();
    }

    public void show(){
        fill(255);
        ellipseMode(CENTER);
        ellipse(centre.getX(), centre.getY(), radius, radius);
    }
}
class Block {
    // Rectangle position;
    Point pos, endPos;

    // Rectangle Coordinates
    Point upleft, upright, downleft, downright;

    //
    float w = 100;
    float h = 30;
    int c;
    boolean alive = true;

    Block(int i, int j) {
        initPos(i, j);
        c = color(random(1, 255), random(1, 255), random(1, 255));
    }

    Block(int i, int j, float r, float g, float b){
        initPos(i, j);
        c = color(r, g, b);
    }

    Block(int i, int j, int c) {
        initPos(i, j);
        this.c = c;
    }

    public void initPos(int i, int j) {
        pos = upleft = new Point(i * w, j * h);
        endPos = upright = new Point(pos.getX() + w, pos.getY());
        downleft  = new Point(pos.getX()    , pos.getY() + h);
        downright = new Point(pos.getX() + w, pos.getY() + h);
    }

    public boolean isTop(Ball ball) {
        return (ball.centre.getX() > upleft.getX() &&
                ball.centre.getX() < upright.getX())
            && (ball.centre.getY() == upleft.getY());
    }

    public boolean isBottom(Ball ball) {
        return (ball.centre.getX() > downleft.getX() &&
                ball.centre.getX() < downright.getX())
            && (ball.centre.getY() == downleft.getY());
    }

    public boolean isRight(Ball ball) {
        return (ball.centre.getY() >   upright.getY() &&
                ball.centre.getY() < downright.getY())
            && (ball.centre.getX() == upright.getX());
    }

    public boolean isLeft(Ball ball) {
        return (ball.centre.getY() >   upleft.getY() &&
                ball.centre.getY() < downleft.getY())
            && (ball.centre.getX() == upleft.getX());
   }

    private boolean isTouched(Ball ball) {
        boolean touched = false;
        if (isTop(ball) || isBottom(ball)) {
            ball.vector.changeWayY();
            touched = true;
        } else if (isLeft(ball) || isRight(ball)) {
            ball.vector.changeWayX();
            touched = true;
        }
        return touched;
    }

    public boolean isAlive() {
        return alive;
    }



    public void update(Ball ball, Player player){
        if (isTouched(ball)) {
            player.addPoints();
            alive = false;
        }
    }

    public void show(){
        fill(c);
        rect(pos.getX(), pos.getY(), w, h);
    }
}
class Coordinate {
    private float x, y;

    Coordinate(float x, float y) {
        this.x = x; this.y = y;
    }

    public float getX() {
        return x;
    }

    public void setX(float x) {
        this.x = x;
    }

    public void moveX(float x) {
        setX(getX() + x);
    }

    public float getY() {
        return y;
    }

    public void setY(float y) {
        this.y = y;
    }

    public void moveY(float y) {
        setY(getY() + y);
    }

    public void move(float x, float y) {
        moveX(x);
        moveY(y);
    }
}
class Line {
    Point pos;
    Point endPos;
    private float w, h;
    private float velocity = 35;

    Line(){
        restore();
    }

    private void defaultSize() {
        w = 100; h = 5;
    }

    private void initPos() {
        pos = new Point(450, 655);
        endPos = new Point(pos.getX() + w, pos.getY());
    }

    private void move(float x) {
        pos.moveX(x);
        endPos.moveX(x);
    }

    public void restore() {
        defaultSize();
        initPos();
    }

    public float getWidth() {
        return w;
    }

    public void update(int k){
        switch(k){
          case 37: if(pos.getX() > 0) move(-1*velocity);
          break;
          case 39: if(pos.getX() < width - w) move(velocity);
          break;
          default:
          break;
        }
    }

    public void show(){
        fill(255);
        rect(pos.getX(), pos.getY(), w, h);
    }
}
class Player {
    String name;
    private float score;
    private byte lives;

    Player(String s){
        name=s;
        score=0;
        lives=3;
    }

    public void show(){
        fill(255);
        text(name+" : " +score, width-80, height-40);
        text("lives: " + lives, width-80, height-30);
    }

    public boolean lost(){
        return lives==0;
    }

    public void looseLives() {
        if (lives > 0)
            lives -= 1;
    }

    public void addPoints() {
        addPoints(100);
    }

    public void addPoints(float points) {
        score += points;
    }
}
class Point extends Coordinate {
    Point(float x, float y) {
        super(x, y);
    }
}
class Vector extends Coordinate {
    Vector(float x, float y) {
        super(x, y);
    }

    Vector(Point a, Point b) {
        super(b.getX() - a.getX(), b.getY() - a.getY());
    }

    Vector(Point o, float angle, float modulus) {
        super((modulus * cos(angle)) - o.getX(), (modulus * sin(angle)) - o.getY());
    }

    public void changeWayX() {
        setX(getX() * -1);
    }

    public void changeWayY() {
        setY(getY() * -1);
    }
}
  public void settings() {  size(1000, 720);  smooth(2); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Blocker" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
