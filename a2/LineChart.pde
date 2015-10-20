class LineChart extends Chart {
  // radius of the points
  float pointSize;
  // distance between the center of each point
  float interval;
  // parallel arrays to store the x and y coordinates of each point
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
    
    x = xyAxes.x_origin + (interval/2) + (pointSize/4);
    for(int i = 0; i < len; i++){
      y = (xyAxes.lenY + 15) - (data.get(i).val * xyAxes.lenY / xyAxes.y_max) + (pointSize/4);
      xs[i] = x;
      ys[i] = y;
      x += interval;
    }
  }
  
  void render(){
    float distance;
    Datum point;
    
    xyAxes.render();
    renderLines();
    renderPoints();
  } 
  
  void renderPoints(){
    int npoints = data.size();
    if (npoints <= 0) return; 
    
    strokeWeight(0.5);
    stroke(0);
    fill(color(255,0,0));
    
    for(int i = 0; i < npoints; i++){
    Datum point = data.get(i);
    float distance = sqrt( pow(xs[i] - mouseX, 2) + pow(ys[i] - mouseY, 2));
    if (distance < pointSize) {
      fill(0);
      textAlign(CENTER);
      text(point.label + ", " + point.val, xs[i], ys[i] - 15);
      fill(color(255,0,0));
    } else {
      fill(0);
    }
        
      ellipse(xs[i], ys[i], pointSize, pointSize); 
      //println("xs["+i+"] = "+ xs[i] +", ys["+i+"] = "+ ys[i]);
    }
  }
  
  void renderLines(){
    fill(0);
    int npoints = data.size();
    for(int i = 0; i < npoints; i++){
        if(i+1 < npoints)
        line(xs[i], ys[i], xs[i+1], ys[i+1]);
    }
  }
  
  void toBarChart(BarChart bc){
    int len = data.size();
    float endX, endY;
    t = 0;
    float radius = pointSize/2;
    
    //remove lines
    if (counter >= 0 && counter < 50){
      fill(0);
      xyAxes.render();
      renderPoints();
      for(int i = 1; i < len; i++){
        endX = lerp(xs[i], xs[i-1], 0.02*(50 - counter));
        endY = lerp(ys[i], ys[i-1], 0.02*(50 - counter));
        line(xs[i], ys[i], endX, endY); 
      }
    }
    if (counter >= 50 && counter < 75){
     fill(0);
     int c = counter - 50;

     float c_radius = lerp(radius, 0, 0.04*c);

     xyAxes.render();
     for(int i = 0; i < len; i++){
       rectMode(CENTER);
       rect(xs[i], ys[i], pointSize, pointSize, c_radius); 
     }
    }
    if (counter >= 75 && counter < 175){
      xyAxes.render();
      float c = counter - 75;
      rectMode(CORNER);
      float hgt, corner_x, corner_y;
      for(int i = 0; i < len; i++){
        corner_x = xs[i] - radius;
        corner_y = ys[i] - radius;
        hgt = lerp(pointSize, xyAxes.y_origin - ys[i], 0.01*c); 

        rect(corner_x, corner_y, pointSize, hgt); 
      }
    } if (counter >= 175 && counter < 225){
        rectMode(CENTER);
        xyAxes.render();
        float c = counter - 175;
        float wdt, hgt, center_x, center_y;
        for(int i = 0; i < len; i++){
          hgt = xyAxes.y_origin - ys[i];
          //center_x = xs[i] + radius;
          center_y = ys[i] + (hgt/2);
 
          wdt = lerp(pointSize, myBar.bar_width, 0.02*c); 
          rect(xs[i], center_y, wdt, hgt); 
        }        
      
    }
    
    
    
    // set myline.wasSelected = false
  
  }
  
    
    //function complete.
    //draw() draws the bar
  
  void toPieChart(PieChart pc){
   //transition line chart to pie chart 
  }
  
  
}