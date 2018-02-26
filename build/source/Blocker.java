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
Ball myballs = new Ball();
boolean gameStarted = false;
int contador = 0;

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
    for (int i = 0; i < blocks.length; i++){
        blocks[i].show();
        blocks[i].update();
    }

    lit.show();
    myballs.show();
    if(gameStarted)
        myballs.update(lit);
    if(myballs.pos.getY() == height){
        myballs.restore();
        lit.reset();
        gameStarted=false;
    }
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
    Point pos;
    // float xl, yl;
    float radius;
    float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        initPos();
        initVector();
    }

    public void initPos() {
        radius = 15;
        pos = new Point(500, 640);
    }

    public void initVector() {
        vctx = random(4, -4);
        vcty = -4;
    }

    public void update(Line line){
        if ((pos.getX() > line.pos.getX()
            && pos.getX() < line.pos.getX() + line.getWidth())
            && pos.getY() + radius == line.pos.getY()) {
            vcty *= -1;
        }

        if(pos.getY() == 0){
            vcty *= -1;
        }

        if(pos.getX() == 0 || pos.getX() == width){
            vctx *= -1;
        }

        pos.move(vctx*vx, vcty*vy);
    }

    public void restore(){
        initPos();
        initVector();
    }

    public void show(){
        fill(255);
        ellipse(pos.getX(), pos.getY(), radius, radius);
    }
}
class Block {
    Point pos;
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
    }

    public void remove() {
        c = color(0, 0, 0);
    }

    public void update(){

    }


    public void show(){
        fill(c);
        rect(pos.getX(), pos.getY(), w, h);
    }
}
class Line {
    // Se va a dejar de usar
    // float a, b;
    // ------ //
    Point pos;
    private float w, h;


    Line(){
        initPos();
        defaultSize();
    }

    public void defaultSize() {
        w = 100; h = 5;
    }

    public void initPos() {
        pos = new Point(450, 650);
    }

    public void reset() {
        initPos();
    }

    public float getWidth() {
        return w;
    }

    public void update(int k){
        switch(k){
          case 37: if(pos.getX() > 0) pos.moveX(-10);
          break;
          case 39: if(pos.getX() < width - w) pos.moveX(10);
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
class Point {
    private float x, y;
    
    Point(float x, float y) {
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
