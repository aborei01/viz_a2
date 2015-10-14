color C2 = color(50, 55, 100);

class myButton {
 float centerX, centerY, leftX, leftY, hgt, wdt;
 String string;
 color clr;
 Boolean selected, wasSelected;

 myButton (float x, float y, float w, float h, String str, color c){
     centerX = x;
     centerY = y;
     leftX = (x - (w/2));
     leftY = (y - (h/2));
     wdt = w;
     hgt = h;
     string = str;
     clr = c;
     selected = wasSelected = false;
     
   }
   
 void setCenter(float x, float y){
   centerX = x;
   centerY = y;
 }
 
 void setSize(float h, float w){
   hgt = h;
   wdt = w;
 }
 
 void setSelected(Boolean b){
   selected = b;
 }
 
 void setWasSelected(Boolean b){
   wasSelected = b;
 }

 void render() {
   textAlign(CENTER, CENTER);
   if(selected) fill(C2);
   else fill(clr);
   rectMode(CENTER);
   strokeWeight(0.5);
   rect(centerX, centerY, wdt, hgt, hgt/10, hgt/10, hgt/10, hgt/10);
   fill(0, 0, 0);
   textSize(12); 
   text(string, centerX, centerY); 
 }

 boolean isInside(){
   if ((mouseX >= leftX) && (mouseX <= (leftX + wdt))) {
     if ((mouseY >= leftY) && (mouseY <= (leftY + hgt))) {
       return true;
       } 
     else return false;
     }
   else return false;
   }

}