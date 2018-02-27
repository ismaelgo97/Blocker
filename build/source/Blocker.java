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
        // Only if you want to use mouse
        // lit.update();
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
    private float diameter;
    Vector vector;
    float vx = 1;
    float vy = 1;

    Ball(){
        restore();
    }

    private void initPos() {
        diameter = 15;
        centre = new Point(500, 640);
    }

    private void initVector() {
        vector = new Vector(random(4, -4), -4);
    }

    public float getRadius() {
        return diameter/2;
    }

    private boolean isTouchingLine(Line line) {
        // float p = new Vector(centre, line.pos).getLength() + getRadius();
        // float e = new Vector(centre, line.endPos).getLength() + getRadius();
        // return p;
        return this.centre.getX() - getRadius() > line.pos.getX()
            && this.centre.getX() + getRadius() < line.endPos.getX()
            && this.centre.getY() == line.pos.getY();
    }

    private boolean isTouchingTopBorder() {
        return this.centre.getY() <= 0;
    }

    private boolean isTouchingSideBorders() {
        return this.centre.getX() <= 0
            || this.centre.getX() >= width;
    }

    public boolean isTouchingDown() {
        return this.centre.getY() >= height;
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
        ellipse(centre.getX(), centre.getY(), diameter, diameter);
    }
}
class Block {
    // Rectangle position;
    Point centre;

    Vector corner, vertical, horizontal;

    //
    final float w = 100;
    final float h = 30;

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
        centre = new Point(i * w + w/2, j * h);
        float x = centre.getX();
        float y = centre.getY();

        corner      = new Vector(centre, new Point(x + distFromCentre(w), y + distFromCentre(h)));
        horizontal  = new Vector(centre, new Point(x + w, y));
        vertical    = new Vector(centre, new Point(x, y + h));
    }

    public float distFromCentre(float d) {
        return d/2;
    }

    public boolean isTop(Ball ball) {

        float d = new Vector(ball.centre, centre).getLength() + ball.getRadius();
        return d <= corner.getLength();

        // return (ball.centre.getX() >= upleft.getX() &&
        //         ball.centre.getX() <= upright.getX())
        //     && (ball.centre.getY() + ball.getRadius() == upleft.getY());
    }

    public boolean isBottom(Ball ball) {

        float d = new Vector(ball.centre, centre).getLength() + ball.getRadius();
        return d <= corner.getLength();
        // return (ball.centre.getX() >= downleft.getX() &&
        //         ball.centre.getX() <= downright.getX())
        //     && (ball.centre.getY() - ball.getRadius() == downleft.getY());
    }

    public boolean isRight(Ball ball) {

        float d = new Vector(ball.centre, centre).getLength() + ball.getRadius();
        return d <= corner.getLength();

        // return (ball.centre.getY() - ball.getRadius() >=   upright.getY() &&
        //         ball.centre.getY() - ball.getRadius() <= downright.getY())
        //     && (ball.centre.getX() == upright.getX());
    }

    public boolean isLeft(Ball ball) {

        float d = new Vector(ball.centre, centre).getLength() + ball.getRadius();
        return d <= corner.getLength();

        // return (ball.centre.getY() + ball.getRadius() >=   upleft.getY() &&
        //         ball.centre.getY() + ball.getRadius() <= downleft.getY())
        //     && (ball.centre.getX() == upleft.getX());
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
        rectMode(CENTER);
        rect(centre.getX(), centre.getY(), w, h);
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
    Point centre;
    private float w, h;
    private float velocity = 35;

    Line(){
        restore();
    }

    private void defaultSize() {
        w = 100; h = 5;
    }

    private void initPos() {
        centre = new Point(width/2, 655);
        pos = new Point(centre.getX() - w/2, centre.getX());
        endPos = new Point(centre.getX() + w/2, centre.getY());
    }

    private void move(float x) {
        centre.moveX(x);
        pos.moveX(x);
        endPos.moveX(x);
    }

    private void moveTo(float x) {
        centre.setX(x);
        pos.setX(x);
        endPos.setX(x + w);
    }

    public void restore() {
        defaultSize();
        initPos();
    }

    public float getWidth() {
        return w;
    }

    public float getHeight() {
        return h;
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

    public void update() {
        if (pos.getX() > 0 && pos.getX() < width - w) moveTo(mouseX);
    }

    public void show(){
        fill(255);
        rectMode(CENTER);
        rect(centre.getX(), centre.getY(), w, h);
    }
}
class Player {
    String name;
    private float score;
    private byte lives;

    Player(String s){
        name=s;
        score=0;
        lives=30;
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

    public float distance(Point b) {
        return sqrt(pow(b.getX() - this.getX(), 2) + pow(b.getY() - this.getY(), 2));
    }
}
class Vector extends Coordinate {

    private float mod;
    private Point a, b;

    Vector(float x, float y) {
        super(x, y);
    }

    Vector(Point a, Point b) {
        super(b.getX() - a.getX(), b.getY() - a.getY());
        mod = abs(a.distance(b));
    }

    Vector(Point o, float angle, float modulus) {
        super((modulus * cos(angle)) - o.getX(), (modulus * sin(angle)) - o.getY());
    }

    public float getLength() {
        return mod;
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
