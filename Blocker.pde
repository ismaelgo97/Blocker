
Block[] blocks = new Block[60];
Line lit = new Line();
Ball ball = new Ball();
boolean gameStarted = false;

color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color yellow = color(255, 255, 0);

void setup(){
    size(1000, 720);
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


void draw(){
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

    for (int i = 0; i < blocks.length; i++){
        if (blocks[i].isAlive()) {
            blocks[i].show();
            blocks[i].update(ball);
        }
    }

    ball.show();
    
    fill(255);
    text("Created by Ismael and Carlos   (C) 2018", 20, 700);
}

void keyPressed() {
    if(gameStarted) {
        lit.update(keyCode);
    }
    if(key==32) {
        gameStarted=true;
    }
}
