
Block[] blocks = new Block[60];
Line lit = new Line();
Ball myballs = new Ball();
boolean gameStarted = false;
int contador = 0;

Color[] colorScheme = {
    Colors.Red,
    Colors.Blue,
    Colors.Yellow,
    Colors.Green
};

void setup(){
    size(1000, 720);
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


void draw(){
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

 void keyPressed() {
    if(gameStarted) {
        lit.update(keyCode);
    }
    if(key==32) {
        gameStarted=true;
    }
}
