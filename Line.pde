class Line{
    float a, b;

    Line(){
        initPos();
    }

    void initPos() {
        a=450;
        b=650;
    }

    void reset() {
        initPos();
    }

    void update(int k){
        switch(k){
          case 37: if(a>0) a=a-10;
          break;
          case 39: if(a<900) a=a+10;
          break;
          default:
          break;
        }
    }

    void show(){
        fill(255);
        rect(a, b, 100, 5);
    }
}
