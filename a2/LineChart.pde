class LineChart extends Chart {
  float pointSize, interval;
  Float[] xs, ys;
  
  int t;
  
  LineChart(float x, float y){
    super(x, y);
  }  
  
  void setPointSize_Intv(){
    int npoints = data.size();
    interval = xyAxes.lenX / npoints;
    pointSize = interval * .25;
  }
  
  void setPoints(){
    float x, y;
    int len = data.size();
    
    xs = new Float[data.size()];
    ys = new Float[data.size()];
    
    x = xyAxes.x_origin;
    for(int i = 0; i < len; i++){
      y = (xyAxes.lenY + 15) - (data.get(i).val * xyAxes.lenY / xyAxes.y_max);
      xs[i] = x;
      ys[i] = y;
      x += interval;
    }
  }
  
  void render(){
    float distance;
    Datum point;
    
    xyAxes.render();
    
    // get data to display from parser
    int npoints = data.size();
    if (npoints <= 0) return;
    
    strokeWeight(0.5);
    stroke(0);
    fill(color(255,0,0));
    
    // Display points
    for(int i = 0; i < npoints; i++){
      point = data.get(i);
      distance = sqrt( pow(xs[i] - mouseX, 2) + pow(ys[i] - mouseY, 2));
      if (distance < pointSize) {
        fill(0);
        textAlign(CENTER);
        text(point.label + ", " + point.val, xs[i], ys[i] - 15);
        fill(color(255,0,0));
      } else {
        fill(255);
      }
      if(i+1 < npoints)
        line(xs[i], ys[i], xs[i+1], ys[i+1]);
        
      stroke(0);
      ellipse(xs[i], ys[i], pointSize, pointSize); 
    }
  } 
  
  void toBarChart(BarChart bc){
    int len = data.size();
    float endX, endY;
    t = 0;
    
    //remove lines
    for(int i = len - 1; i > 0; i--){ 
      fill(255);
      endX = lerp(xs[i], xs[i-1], 0.1*i);
      endY = lerp(ys[i], xs[i-1], 0.1*i);
      line(xs[i], ys[i], endX, endY); 
    }
    
    
    //grow point size
    
    //turn circle to a square with very round corners
    
    //drop down round squares
    
    //turn round squares to square squares
    // set myline.wasSelected = false
  }
    
    //function complete.
    //draw() draws the bar
  
  void toPieChart(PieChart pc){
   //transition line chart to pie chart 
  }
  
  
}