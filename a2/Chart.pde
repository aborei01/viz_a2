class Chart{
 ArrayList<Datum> data;
 Axis xyAxes;
 float[] xs, ys;
 // distance between the center of each point
 float interval;
 int size; //number of data points
  //creates empty barchart
  Chart(float x, float y){
   xyAxes = new Axis(x, y);
   data = new ArrayList<Datum>();
  }

  void addDatum(String name, float value) {
    data.add(new Datum(name, value));
  }
  
  void setPoints(){
    size = data.size();
    xs = new float[size];
    ys = new float[size];
    float x, y;
    
    interval = xyAxes.lenX / size;
    
    
    x = xyAxes.x_origin;
    for(int i = 0; i < size; i++){
      //set x coordinate
      xs[i] = x;
      x += interval;
      
      //set y coordinate
      y = data.get(i).val * xyAxes.lenY / xyAxes.y_max;
      ys[i] = xyAxes.y_origin - y; 
    }
  }

  
}