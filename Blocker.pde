
Block[] blocks = new Block[60];
Line lit = new Line();
Ball ball = new Ball();

Player player = new Player("Pepe");

boolean gameStarted = false;

color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color yellow = color(255, 255, 0);

int initRow = 3;

void setup(){
    size(1000, 720);
    smooth(2);
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

void reset() {
    ball.restore();
    lit.restore();
    gameStarted=false;
}

void draw(){
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

void keyPressed() {
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
