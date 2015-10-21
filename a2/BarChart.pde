class BarChart extends Chart {
  float bar_width;

  BarChart(float x, float y){
    super(x, y);
  }
  
  void setBarWid(){
    bar_width =  interval * .8;
  }

void render(){
  xyAxes.render();
  renderBars();
}

  
  void renderBars(){
    strokeWeight(0.5);
    stroke(0);
    fill(0);
    rectMode(CORNER);
    
    for(int i = 0; i < size; i++){
      if (isMouseOver(xs[i], ys[i])) highlightBar(i);
      else fill(0);
      rect(xs[i], ys[i], bar_width, xyAxes.y_origin - ys[i]);
    }
    
  }
  
  boolean isMouseOver(float _x, float _y){
    return mouseX >= _x && mouseX <= _x + bar_width &&
           mouseY >= _y && mouseY <= xyAxes.y_origin;
  }
  
  void highlightBar(int i){
    fill(0);
    textAlign(CENTER);
    Datum i_bar = data.get(i);
    
    text(i_bar.label + ", " + i_bar.val, xs[i] + bar_width / 2, ys[i] - 10);
    fill(color(255,0,0));
  }
  
  void toLineChart(LineChart lc){
   //narrow bars to pointsize 
   if (counter >= 0 && counter < 50){
        rectMode(CORNER);
        xyAxes.render();
        float wdt, hgt;
        
        for(int i = 0; i < size; i++){
          hgt = xyAxes.y_origin - ys[i];
          wdt = lerp(myBar.bar_width, myLine.pointSize, 0.02*(counter)); 
          rect(xs[i], ys[i], wdt, hgt); 
        }  
    }
    // retract bars
    if (counter >= 50 && counter < 150){
      xyAxes.render();
      float c = counter - 50;
      rectMode(CORNER);
      float hgt;
      for(int i = 0; i < size; i++){
        hgt = lerp(xyAxes.y_origin - ys[i], myLine.pointSize, 0.01*c); 
        rect(xs[i], ys[i], myLine.pointSize, hgt); 
      }
    }
    //squares to circles
    if (counter >= 150 && counter < 175){
     fill(0);
     int c = counter - 150;
     float c_radius = lerp(0, (myLine.pointSize / 2), 0.04*c);
     xyAxes.render();
     for(int i = 0; i < size; i++){
       rectMode(CORNER);
       rect(xs[i], ys[i], myLine.pointSize, myLine.pointSize, c_radius); 
     }
    }
    //connect data points
    if (counter >= 175 && counter < 225){
      float endX, endY;
      fill(0);
      xyAxes.render();
      myLine.renderPoints();
      for(int i = 1; i < size; i++){
        endX = lerp(xs[i-1] + (myLine.pointSize / 2), xs[i] + (myLine.pointSize / 2), 0.02*(175 - counter));
        endY = lerp(ys[i-1] + (myLine.pointSize / 2), ys[i] + (myLine.pointSize / 2), 0.02*(175 - counter));
        line(xs[i] + (myLine.pointSize / 2), ys[i] + (myLine.pointSize / 2), endX, endY); 
      }
    }
    
  }
  void toPieChart(PieChart pc){
   //transition barchart to piechart 
  }
}