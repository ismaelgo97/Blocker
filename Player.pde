class Player {
    String name;
    float score;
    float lives;

    Player(String s){
        name=s;
        score=0;
        lives=3;
    }

    void show(){
        text(name+" : " +score, width-80, height-40);
        text("lives: " + lives, width-80, height-30);
    }

    boolean lost(){
        return lives==0;
    }

    void update(boolean isAlive, Ball ball){
        if (!isAlive) {
            score += 100;
        }
        if (ball.isTouchingDown()){
            lives-=1;
        }
    }
}
