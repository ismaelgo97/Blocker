class Player {
    String name;
    private float score;
    private byte lives;

    public Player(String name){
        this.name=name;
        score = 0;
        lives = 3;
    }

    void show(){
        fill(0);
        text(name + " : " + score + " ", width-80, height-40);
        text("Lives: " + lives + " ", width-80, height-30);
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
