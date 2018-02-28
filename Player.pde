class Player {
    String name;
    private float score;
    private byte lives;

    Player(String s){
        name=s;
        score=0;
        lives=30;
    }

    void show(){
        fill(255);
        text(name + " : " + score, width-80, height-40);
        text("lives: " + lives, width-80, height-30);
    }

    boolean lost(){
        return lives == 0;
    }

    void looseLives() {
        if (lives > 0)
            lives -= 1;
    }

    void addPoints() {
        addPoints(100);
    }

    void addPoints(float points) {
        score += points;
    }
}
