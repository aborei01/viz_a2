class Axis {
 float y_max = 100, x_max = 100;
 float x_origin, y_origin; //origin of the xy axes
 float lenX, lenY;

// x and y are the lower left, cartesian origin of the plane
 Axis(float x, float y){
   x_origin = x;
   y_origin = height - y;
   lenX = width - 2*x;
   lenY = height - y - 15;
 }

 void render(){
   stroke(0);
   line(x_origin, y_origin, x_origin, 15);         // y axis  
   line(x_origin, y_origin, x_origin + lenX, y_origin); // x axis
 }
}