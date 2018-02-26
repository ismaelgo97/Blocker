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

public void setup(){
    
    int a=0;
    for (int i = 0; i < 2; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, 255, 0, 0);
            a++;
        }
    }
    for (int i = 2; i < 4; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, 0, 255, 0);
            a++;
        }
    }

    for (int i = 4; i < 6; i++){
        for (int j = 0; j < 10; j++){
            blocks[a]= new Block(j, i, 0, 0, 255);
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
        myballs.update();
    if(myballs.y==height){
        myballs.restore();
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
class Ball{

    float x, y, xl, yl;
    float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        initPos();
        initVelocity();
    }

    public void initPos() {
        xl = 15;
        yl = 15;
        x = 500;
        y = 640;
    }

    public void initVelocity() {
        vctx = random(4, -4);
        vcty = -4;
    }

    public void update(){
        if(y==0){
            vcty*=-1;
        }

        if(x==0 || x==width){
            vctx*=-1;
        }

        x=x+vctx*vx;
        y=y+vcty*vy;
    }

    public void restore(){
        initPos();
        initVelocity();
    }

    public void show(){
        fill(255);
        ellipse(x, y, xl, yl);
    }
}
class Block{
    float posx ;
    float posy;
    float ancho=100;
    float alto=30;
    float r, g, b;
    boolean alive = true;


    Block(int i, int j){
        posx=i*100;
        posy=j*30;
        r=random(1, 255);
        g=random(1, 255);
        b=random(1, 255);
    }

    Block(int i, int j, float rr, float gg, float bb){
        posx=i*100;
        posy=j*30;
        r=rr;
        g=gg;
        b=bb;
    }

    public void update(){

    }


    public void show(){
        fill(r,g,b);
        rect(posx, posy, ancho, alto);
    }
}
class Line{
    float a, b;

    Line(){
        initPos();
    }

    public void initPos() {
        a=450;
        b=650;
    }

    public void reset() {
        initPos();
    }

    public void update(int k){
        switch(k){
          case 37:if(a>0) a=a-10;
          break;
          case 39:if(a<900) a=a+10;
          break;
          default:
          break;
        }
    }

    public void show(){
        fill(255);
        rect(a, b, 100, 5);
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
