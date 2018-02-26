class Ball{

    float x, y, xl, yl;
    float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        initPos();
        initVelocity();
    }

    void initPos() {
        xl = 15;
        yl = 15;
        x = 500;
        y = 640;
    }

    void initVelocity() {
        vctx = random(4, -4);
        vcty = -4;
    }

    void update(){
        if(y==0){
            vcty*=-1;
        }

        if(x==0 || x==width){
            vctx*=-1;
        }

        x=x+vctx*vx;
        y=y+vcty*vy;
    }

    void restore(){
        initPos();
        initVelocity();
    }

    void show(){
        fill(255);
        ellipse(x, y, xl, yl);
    }
}
