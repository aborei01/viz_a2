class Chart{
 ArrayList<Datum> data;
 Axis xyAxes;
  
  //creates empty barchart
  Chart(float x, float y){
   xyAxes = new Axis(x, y);
   data = new ArrayList<Datum>();
  }

  void addDatum(String name, float value) {
    data.add(new Datum(name, value)); 
  }

  
}