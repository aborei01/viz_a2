class LineChart extends Chart {
  // radius of the points
  float pointSize;

  // parallel arrays to store the x and y coordinates of each point
  
  int t;
  
  LineChart(float x, float y){
    super(x, y);
  }  
  
  void setLinePoints(){
    setPoints();
    pointSize = interval * 0.25;
  }
  
  void render(){
    float distance;
    Datum point;
    
    xyAxes.render();
    renderLines();
    renderPoints();
  } 
  
  void renderPoints(){
    strokeWeight(0.5);
    stroke(0);
    fill(color(255,0,0));
    
    for(int i = 0; i < size; i++){
    Datum point = data.get(i);
    float distance = sqrt( pow(xs[i] - mouseX, 2) + pow(ys[i] - mouseY, 2));
    if (distance < pointSize) {
      fill(0);
      textAlign(CENTER);
      text(point.label + ", " + point.val, xs[i], ys[i] - 15);
      fill(color(255,0,0));
    } else fill(0);
    ellipse(xs[i] + (pointSize / 2), ys[i]+ (pointSize / 2), pointSize, pointSize); 
  }
}
  
  void renderLines(){
    fill(0);
    println("size: " + size);
    for(int i = 0; i < size - 1; i++){
        line(xs[i]+ (pointSize / 2), ys[i] + (pointSize / 2), 
             xs[i+1] + (pointSize / 2), ys[i+1] + (pointSize / 2));
    }
  }
  
  void toBarChart(BarChart bc){
    float endX, endY;
    t = 0;
    
    //remove lines
    if (counter >= 0 && counter < 50){
      fill(0);
      xyAxes.render();
      renderPoints();
      for(int i = 1; i < size; i++){
        endX = lerp(xs[i] + (pointSize / 2), xs[i-1] + (pointSize / 2), 0.02*(50 - counter));
        endY = lerp(ys[i] + (pointSize / 2), ys[i-1] + (pointSize / 2), 0.02*(50 - counter));
        line(xs[i] + (pointSize / 2), ys[i] + (pointSize / 2), endX, endY); 
      }
    }
    
    //transition from circles to squares
    if (counter >= 50 && counter < 75){
     fill(0);
     int c = counter - 50;

     float c_radius = lerp((pointSize / 2), 0, 0.04*c);

     xyAxes.render();
     for(int i = 0; i < size; i++){
       rectMode(CORNER);
       rect(xs[i], ys[i], pointSize, pointSize, c_radius); 
     }
     
    //drop down bars
    }
    if (counter >= 75 && counter < 175){
      xyAxes.render();
      float c = counter - 75;
      rectMode(CORNER);
      float hgt;
      for(int i = 0; i < size; i++){
        hgt = lerp(pointSize, xyAxes.y_origin - ys[i], 0.01*c); 
        rect(xs[i], ys[i], pointSize, hgt); 
      }
    //widen bars
    } if (counter >= 175 && counter < 225){
        rectMode(CORNER);
        xyAxes.render();
        float c = counter - 175;
        float wdt, hgt;
        for(int i = 0; i < size; i++){
          hgt = xyAxes.y_origin - ys[i];
          wdt = lerp(pointSize, myBar.bar_width, 0.02*c); 
          rect(xs[i], ys[i], wdt, hgt); 
        }         
    }  
  }

  void toPieChart(PieChart pc){
   //transition line chart to pie chart 
  }
  
  
}