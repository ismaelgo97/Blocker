class Ball{
    Point pos;
    // float xl, yl;
    float radius;
    float vctx, vcty;
    int vx = 1;
    int vy = 1;

    Ball(){
        initPos();
        initVelocity();
    }

    void initPos() {
        radius = 15;
        pos = new Point(500, 640);
    }

    void initVelocity() {
        vctx = random(4, -4);
        vcty = -4;
    }

    void update(){
        if(pos.getY() == 0){
            vcty*=-1;
        }

        if(pos.getX() == 0 || pos.getX() == width){
            vctx*=-1;
        }

        pos.move(vctx*vx, vcty*vy);
    }

    void restore(){
        initPos();
        initVelocity();
    }

    void show(){
        fill(255);
        ellipse(pos.getX(), pos.getY(), radius, radius);
    }
}
