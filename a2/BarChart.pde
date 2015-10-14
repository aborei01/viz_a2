class BarChart extends Chart {
  
  float bar_width, interval;

  BarChart(float x, float y){
    super(x, y);
  }
  
  void setBarWid_Intv(){
    int nbars = data.size();
    // the length of the axis is width - 10 - location of x origin
    interval = (width - 10 - xyAxes.x_origin) / nbars;
    bar_width =  interval * .8;
  }

void render(){
    xyAxes.render();
    // Display bars
    strokeWeight(0.5);
    stroke(0);
    fill(color(255,0,0));
    int nbars = data.size();
        println("nbars: " + nbars);

  // bar_corner is bottom left corner
    float bar_corner = xyAxes.x_origin;
    Datum i_bar;
    float top_left_x;
    float top_left_y;
    float bar_height;
    boolean isMouseOver = false;
    for (int i = 0; i < nbars; i++) {
      //scale height later
      i_bar = data.get(i);
      top_left_x = bar_corner + (interval - bar_width) / 2;
      bar_height = i_bar.val * xyAxes.lenY / xyAxes.y_max;
      top_left_y = xyAxes.y_origin - bar_height;

      isMouseOver = mouseX >= top_left_x && mouseX <= top_left_x + bar_width &&
                    mouseY >= top_left_y && mouseY <= xyAxes.y_origin;

      if (isMouseOver) {
        fill(0);
        textAlign(CENTER);
        text(i_bar.label + ", " + i_bar.val, top_left_x + bar_width / 2, top_left_y - 10);
        fill(color(255,0,0));
      } else {
        fill(255);
      }

      rectMode(CORNER);
      rect(top_left_x, top_left_y, bar_width, bar_height);
      bar_corner += interval;
    }
  }
  
  void toLineChart(LineChart lc){
   //transition barchart to linechart 
  }
  
  void toPieChart(PieChart pc){
   //transition barchart to piechart 
  }
}