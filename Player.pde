class Player {
    String name;
    float score;

    Player(String s){
        name=s;
        score=0;
    }

    void show(){
        text(name+" : "+score, width-80, height-40);
    }

    void update(Block block){
        if (block.isTouched()) {
            score += 100;
        }
    }
}
