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


Block[] blocks;
Line lit;
Ball ball;
Player player;

boolean gameStarted = false;

int red = color(255, 0, 0);
int green = color(0, 255, 0);
int blue = color(0, 0, 255);
int yellow = color(255, 255, 0);

int initRow = 3;

public void setup(){
    
    

    blocks = new Block[60];
    lit = new Line();
    ball = new Ball();
    player = new Player("Pepe");

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
            blocks[a++]= new Block(j, i, 100, 30, red);
        }
    }

    for (int i = initRow+2; i < initRow+4; i++){
        for (int j = 0; j < 10; j++){
            blocks[a++]= new Block(j, i, 100, 30, green);
        }
    }

    for (int i = initRow+4; i < initRow+6; i++){
        for (int j = 0; j < 10; j++){
            blocks[a++]= new Block(j, i, 100, 30, blue);
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
            gameStarted=true;
        }
        if(gameStarted) {
            lit.update(keyCode);
        }
    } else {
        if(key==32) {
            reset();
        }
    }
}
class Ball extends Point {

    HitBox hb;
    Vector vector;

    private final float diameter = 15;

    float vx = 1;
    float vy = 1;

    Ball() {
        super(width/2, height - 80);
        hb = new HitBox(diameter, diameter, this);
        restore();
    }

    private void initPos() {
        setX(width/2); setY(height - 80);
    }

    private void initVector() {
        vector = new Vector(random(6, -6), -4);
    }

    public float getRadius() {
        return diameter / 2;
    }

    private boolean isTouchingLine(Line line) {
        // float p = new Vector(centre, line.pos).getLength() + getRadius();
        // float e = new Vector(centre, line.endPos).getLength() + getRadius();
        // return p;
        return getX() >= line.hb.upleft.getX()
            && getX() <= line.hb.upright.getX()
            && getY() + getRadius() >= line.getY() - line.getHeight();
    }

    private boolean isTouchingTopBorder() {
        return getY() - getRadius() <= 0;
    }

    private boolean isTouchingSideBorders() {
        return getX() - getRadius() <= 0
            || getX() + getRadius() >= width;
    }

    public boolean isTouchingDown() {
        return getY() + getRadius() >= height;
    }

    public void update() {
        if (isTouchingSideBorders()) {
            vector.changeWayX();
        }
        if (isTouchingTopBorder()) {
            vector.changeWayY();
        }
        move(vector.getX()*vx, vector.getY()*vy);
        hb.update(this);
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
        ellipse(getX(), getY(), diameter, diameter);
    }
}
class Block extends Point {

    HitBox hb;
    int c;
    boolean alive = true;

    Block(int i, int j, float w, float h) {
        super(i * w + w/2, j * h);
        hb = new HitBox(w, h, this);
        c = color(random(1, 255), random(1, 255), random(1, 255));
    }

    Block(int i, int j, float w, float h, float r, float g, float b){
        super(i * w + w/2, j * h);
        hb = new HitBox(w, h, this);
        c = color(r, g, b);
    }

    Block(int i, int j, float w, float h, int c) {
        super(i * w + w/2, j * h);
        hb = new HitBox(w, h, this);
        this.c = c;
    }

    public float getDistanceFrom(Ball ball) {
        return hb.getDistance(ball.hb) - ball.hb.getWidth()/2;
    }

    public boolean isTop(Ball ball) {
        return getDistanceFrom(ball) <= hb.vertical.getLength();

        // return (ball.centre.getX() >= upleft.getX() &&
        //         ball.centre.getX() <= upright.getX())
        //     && (ball.centre.getY() + ball.getRadius() == upleft.getY());
    }

    public boolean isBottom(Ball ball) {
        return getDistanceFrom(ball) <= hb.vertical.getLength();
        // return (ball.centre.getX() >= downleft.getX() &&
        //         ball.centre.getX() <= downright.getX())
        //     && (ball.centre.getY() - ball.getRadius() == downleft.getY());
    }

    public boolean isRight(Ball ball) {
        // System.out.println(getDistanceFrom(ball) + " " + hb.horizontal.getLength());
        return getDistanceFrom(ball) <= hb.horizontal.getLength();
        // && (ball.centre.getY() - ball.getRadius() >=   upright.getY() &&
        //     ball.centre.getY() - ball.getRadius() <= downright.getY());

        // return (ball.centre.getY() - ball.getRadius() >=   upright.getY() &&
        //         ball.centre.getY() - ball.getRadius() <= downright.getY())
        //     && (ball.centre.getX() == upright.getX());
    }

    public boolean isLeft(Ball ball) {
        return getDistanceFrom(ball) <= hb.horizontal.getLength();
        // && (ball.centre.getY() + ball.getRadius() >=   upleft.getY() &&
        //     ball.centre.getY() + ball.getRadius() <= downleft.getY());

        // return (ball.centre.getY() + ball.getRadius() >=   upleft.getY() &&
        //         ball.centre.getY() + ball.getRadius() <= downleft.getY())
        //     && (ball.centre.getX() == upleft.getX());
   }

    private boolean isTouchedBy(Ball ball) {
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
        if (isTouchedBy(ball)) {
            player.addPoints();
            alive = false;
        }
    }

    public void show(){
        fill(c);
        rectMode(CENTER);
        rect(getX(), getY(), hb.getWidth(), hb.getHeight());
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
class HitBox {
    private Point up, down, left, right;
    Point upleft, upright, downleft, downright;

    Point centre;

    private Vector corner, vertical, horizontal;

    private float w, h;

    HitBox(float w, float h, Point centre) {
        setWidth(w);
        setHeight(h);
        update(centre);
    }

    private void setPoints() {
        up      = new Point(
            centre.getX(), centre.getY() - getHeight()/2
        );
        down    = new Point(
            centre.getX(), centre.getY() + getHeight()/2
        );
        left    = new Point(
            centre.getX() - getWidth()/2, centre.getY()
        );
        right   = new Point(
            centre.getX() + getWidth()/2, centre.getY()
        );

        // ------------------ //
        upleft      = new Point(
            left.getX(), up.getY()
        );
        upright     = new Point(
            right.getX(), up.getY()
        );
        downleft    = new Point(
            left.getX(), down.getY()
        );
        downright   = new Point(
            right.getX(), down.getY()
        );
        // ------------------ //
    }

    private void setVectors() {
        corner      = new Vector(centre, downright);
        horizontal  = new Vector(centre, right);
        vertical    = new Vector(centre, down);
    }

    public float getWidth() {
        return w;
    }

    public float getHeight() {
        return h;
    }

    public void setWidth(float w) {
        this.w = w;
    }

    public void setHeight(float h) {
        this.h = h;
    }

    public void setCentre(Point centre) {
        this.centre = centre;
    }

    public float getDistance(HitBox hb) {
        return new Vector(centre, hb.centre).getLength();
    }

    public void update(Point centre) {
        setCentre(centre);
        setPoints();
        setVectors();
    }
}
class Line extends Point {

    HitBox hb;
    private float velocity = 35;

    Line() {
        super(width/2, height - 65);
        hb = new HitBox(100, 5, this);
        restore();
    }

    private void initPos() {
        setX(width/2); setY(height - 65);
        hb.update(this);
    }

    private void move(float x) {
        moveX(x);
    }

    private void moveTo(float x) {
        setX(x);
    }

    public void restore() {
        initPos();
    }

    public float getWidth() {
        return hb.getWidth();
    }

    public float getHeight() {
        return hb.getHeight();
    }

    public void update(int k){
        switch(k){
          case 37:
          if(hb.upleft.getX() > 0)
            move(-1*velocity);
          break;
          case 39:
          if(hb.upright.getX() < width)
            move(velocity);
          break;
          default:
          break;
        }
        hb.update(this);
    }

    public void update() {
        if (getX() > 0 + hb.getWidth()/2 && getX() < width - hb.getWidth()/2)
            moveTo(mouseX);

        hb.update(this);
    }

    public void show(){
        fill(255);
        rectMode(CENTER);
        rect(getX(), getY(), getWidth(), getHeight());
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
        text(name + " : " + score, width-80, height-40);
        text("lives: " + lives, width-80, height-30);
    }

    public boolean lost(){
        return lives == 0;
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
        return sqrt(
            (b.getX() - this.getX())
          * (b.getX() - this.getX())
          + (b.getY() - this.getY())
          * (b.getY() - this.getY())
        );
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
