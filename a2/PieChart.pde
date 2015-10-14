class PieChart {
 public ArrayList<Slice> slices;
 public StringList names; //data labels
 public FloatList values; //data labels
 public String category, unit; //column titles from input data
 public float total;
 private float wid;   //filled portion of slice
 public float offset; //blank portion of slice 
 public boolean isPie;
 public String currLabel;
 public float currValue;


 float prevWid;
 float destWid;
 float prevOffset;
 float destOffset;

 float animationProgress;
 float animationRate = .01;

 public PieChart(String c, String u){
   category = c;
   unit     = u;
   total    = 0;
   wid      = 0;
   offset   = 0;
   slices   = new ArrayList<Slice>();
   names    = new StringList();
   values   = new FloatList();
 }


 public void addSlice(String n, float v){
   total += v;
   names.append(n);
   values.append(v);
   slices.add(new Slice(n, v, wid, offset));
   int len = slices.size();
   float sAng = 0;
   float eAng;
   Slice s; 
   for(int i = 0; i < len; i++){
     s    = slices.get(i);
     eAng = (2 * PI) * (s.value / total) + sAng;
     s.startAng = sAng;
     s.endAng   = eAng;
     slices.set(i, s);
     sAng= eAng;
   }
 }

 public void setOffset(float o){
   prevOffset = offset;
   destOffset = o;
 }

 public void setWidth(float w){
   prevWid = wid;
   destWid = w;
 }

 void SwitchStyle()
 {
  isPie = !isPie;
  animationProgress = 0;
 }

 public void renderLabel(){
   if(!(currLabel == "")){
     fill(0);
     strokeWeight(0.5);
     textSize(14);
     text(currLabel + ", " + currValue, mouseX, mouseY); 
     noFill();
   }
 }

 public void render()
 {
   animationProgress += animationRate;

   if (animationProgress >= 1)
   {
     prevWid = destWid;
     prevOffset = destOffset; 
     animationProgress = 0;
   }

   wid = lerp(prevWid, destWid, animationProgress);
   offset = lerp(prevOffset, destOffset, animationProgress);

   for (Slice s : slices) { 
     s.offset = offset;
     s.wid = wid;
   }

   setWidth(width/3);

   if(isPie) setOffset(width/8);
   else setOffset(0);
   Slice tempSlice;
   int len = slices.size();
   for(int i = 0; i < len; i++) {
     tempSlice = slices.get(i);
     tempSlice.center_x = width / 2;
     tempSlice.center_y = height / 2;
     tempSlice.render();
     slices.set(i, tempSlice);
     if(tempSlice.isMouseOver()){
       currLabel = names.get(i);
       currValue = values.get(i);
     }
   }
 if((dist(mouseX, mouseY, width/2, height/2) > offset + wid) ||
    (dist(mouseX, mouseY, width/2, height/2) < offset))
    currLabel = "";
}

  void toBarChart(BarChart bc){
    //transition piechart to barchart
  }

  void toLineChart(LineChart lc){
    //transition piechart to linechart
  }
}