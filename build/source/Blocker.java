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
boolean gameStarted = false;

int red = color(255, 0, 0);
int green = color(0, 255, 0);
int blue = color(0, 0, 255);
int yellow = color(255, 255, 0);

public void setup(){
    
    int a = 0;
    for (int i = 0; i < 2; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, red);
            a++;
        }
    }
    for (int i = 2; i < 4; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, green);
            a++;
        }
    }

    for (int i = 4; i < 6; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, blue);
            a++;
        }
    }
}


public void draw(){
    background(0);

    if(gameStarted) {
        ball.update(lit);
        if(ball.centre.getY() == height){
            ball.restore();
            lit.restore();
            gameStarted=false;
        }
    }

    lit.show();
    ball.show();

    for (int i = 0; i < blocks.length; i++){
        if (blocks[i].isAlive()) {
            blocks[i].show();
            blocks[i].update(ball);
        }
    }


    fill(255);
    text("Created by Ismael and Carlos   (C) 2018", 20, 700);
}

public void keyPressed() {
    if(gameStarted) {
        lit.update(keyCode);
    }
    if(key==32) {
        gameStarted=true;
    }
}
class Ball {
    Point centre;
    // float xl, yl;
    private float radius;
    private float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        initPos();
        initVector();
    }

    private void initPos() {
        radius = 15;
        centre = new Point(500, 640);
    }

    private void initVector() {
        vctx = random(4, -4);
        vcty = -4;
    }

    public float getRadius() {
        return radius/2;
    }

    private boolean isTouchingLine(Line line) {
        return this.centre.getX() > line.pos.getX()
            && this.centre.getX() < line.endPos.getX()
            && this.centre.getY() + this.getRadius() > line.pos.getY();
    }

    private boolean isTouchingTopBorder() {
        return this.centre.getY() == 0;
    }

    private boolean isTouchingSideBorders() {
        return this.centre.getX() == 0
            || this.centre.getX() == width;
    }

    private boolean isTouchingBlock(Block block) {
        return false;
    }

    public void update() {
        if (isTouchingSideBorders()) {
            vctx *= -1;
        }
        if (isTouchingTopBorder()) {
            vcty *= -1;
        }
        centre.move(vctx*vx, vcty*vy);
    }

    public void update(Line line) {
        if (isTouchingLine(line)) {
            vcty *= -1;
        }
        update();
    }

    public void update(Block block) {

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
    Point pos;
    Point endPos;
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
        pos = new Point(i * w, j * h);
        endPos = new Point(pos.getX() + w, pos.getY());
    }

    private boolean isTouched(Ball ball) {
        if (ball.centre.getX() > pos.getX()
        && ball.centre.getX() < endPos.getX() 
        && pos.getY() + h == ball.centre.getY() - ball.getRadius()) {
            return true;
        } else {
            return false;
        }
    }

    public boolean isAlive() {
        return alive;
    }

    private void remove() {
        alive = false;
        c = color(0, 0, 0);
    }

    public void update(Ball ball){
        if (isTouched(ball)) {
            remove();
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
    // Se va a dejar de usar
    // float a, b;
    // ------ //
    Point pos;
    Point endPos;
    private float w, h;
    private float velocity = 20;


    Line(){
        initPos();
        defaultSize();
    }

    private void defaultSize() {
        w = 100; h = 5;
    }

    private void initPos() {
        pos = new Point(450, 650);
        endPos = new Point(pos.getX() + w, pos.getY());
    }

    private void move(float x) {
        pos.moveX(x);
        endPos.moveX(x);
    }

    public void restore() {
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
class Point extends Coordinate {
    Point(float x, float y) {
        super(x, y);
    }
}
  public void settings() {  size(1000, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Blocker" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
