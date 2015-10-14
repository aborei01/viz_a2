class Slice {
 public float startAng, endAng;
 public int center_x, center_y; //circle center
 private float pos; // position from the center
 public float value; // data label, actual value
 public String name;  // data label
 public color bg_col; //background colour of slice 
 public float wid;   //filled portion of slice
 public float offset; //blank portion of slice 



 public Slice(){
    center_x = width/2;
    center_y = height/2;
    value = 0;
    name = "";
    bg_col = color(random(0, 255), random(0, 255), random(0, 255));
 }

 public Slice(String n, Float v, Float w, Float o){
   name   = n;
   value  = v;
   wid    = w; 
   offset = o;
   center_x = width/2;
   center_y = height/2;
   startAng = 0;
   endAng = 2 * PI / 3;
   bg_col = color(random(0, 255), random(0, 255), random(0, 255));
 }

 public void render()
 {
   noFill();
   strokeWeight(2);
   for(pos = 0; pos < offset + wid; pos++){
     if(!ShouldDraw()) noStroke();
     else{
       if (isMouseOver()){
         strokeWeight(2);
         stroke(bg_col - 100);
       }
       else stroke(bg_col);
     }
     arc(center_x, center_y, pos*2, pos*2, startAng, endAng); 
   }
 }

  private boolean ShouldDraw(){
   return pos < offset + wid && pos > offset;
 }

 private boolean isMouseOver(){
   int x = mouseX - center_x;
   int y = mouseY - center_y;
   if(x == 0) return false; //can't divide by 0/ user if off screen
   float angle = 0;
   if (y == 0) return false; 

   angle = atan2(y, x); 
   if(y < 0) angle += 2 * PI; 

   float degAng = (angle * 180)/ PI;
   float radius = sqrt(x * x + y * y);

   return((angle >= startAng && angle <= endAng) &&
      (radius < offset + wid && radius > offset));
 }
}