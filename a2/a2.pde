myButton pieButton, lineButton, barButton;
PieChart  myPie;
BarChart  myBar;
LineChart myLine;
String path = "./data.csv";
color C1 = color(255, 204, 0);

int counter;

void setup() {
 size(600, 600);
 surface.setResizable(true);
 
 parse();
 
 counter = 0;

 pieButton = new myButton(width/6, .92*height, 75, 35, "Pie Chart", C1);
 lineButton = new myButton(width/2, .92*height, 75, 35, "Line Chart", C1);
 barButton = new myButton(5*(width/6), .92*height, 75, 35, "Bar Chart", C1);
}

void draw() {
 background(255, 255, 255);
 pieButton.render(); 
 lineButton.render();
 barButton.render();
 
 //rectMode(CENTER);
 //rect(300, 300, (myLine.pointSize)*10, myLine.pointSize*10,(myLine.pointSize)/.02);
 //noLoop();

 if(lineButton.wasSelected && barButton.selected){
   myLine.toBarChart(myBar);
   counter++;

    if(counter >= 225) {
     lineButton.setWasSelected(false);
     barButton.setSelected(true);
     counter = 0;
    }
 }
 if(lineButton.wasSelected && pieButton.selected)
   myLine.toPieChart(myPie);
   
 if(pieButton.wasSelected && barButton.selected)
   myPie.toBarChart(myBar);
 if(pieButton.wasSelected & lineButton.selected)
   myPie.toLineChart(myLine);
 if(barButton.wasSelected & lineButton.selected){
   myBar.toLineChart(myLine);
   counter++;
   if(counter >= 225) { //change this as we incrementally develop
     barButton.setWasSelected(false);
     lineButton.setSelected(true);
     counter = 0;
   }
 }
   
   
 if(barButton.wasSelected & pieButton.selected)
   myBar.toPieChart(myPie);
 
 if(!barButton.wasSelected && !pieButton.wasSelected && !lineButton.wasSelected){  
   if(pieButton.selected  == true)  myPie.render();
   if(lineButton.selected == true) myLine.render();
   if(barButton.selected  == true)  myBar.render();

 }
 
 

 // NEEDSWORK, THIS IS IF ALL TRANSITIONS HAVE THE SAME 
 // NUMBER OF STEPS
 //if (counter > 10) counter = 0;
}

void mouseClicked() {
  if (pieButton.isInside()) {
    if(lineButton.selected) //transition line -> pie 
      lineButton.setWasSelected(true);
    else if (barButton.selected) //transition bar -> pie
      barButton.setWasSelected(true);
    
    pieButton.setSelected(true);
    pieButton.setWasSelected(false);
    lineButton.setSelected(false);
    barButton.setSelected(false);
  }
  if (lineButton.isInside()) {
    if (barButton.selected) //transition bar -> line
      barButton.setWasSelected(true);
    else if (pieButton.selected) //transition pie -> line
      pieButton.setWasSelected(true);
    
    lineButton.setSelected(true);
    lineButton.setWasSelected(false);
    pieButton.setSelected(false);
    barButton.setSelected(false);  
  }
  if (barButton.isInside()) {
    if(lineButton.selected) //transition line -> bar
      lineButton.setWasSelected(true);
    else if(pieButton.selected) //transition pie -> bar
      pieButton.setWasSelected(true);
    
    pieButton.setWasSelected(false);
    pieButton.setSelected(false);
    lineButton.setSelected(false);
    barButton.setSelected(true);
    //noLoop();
  }
}

 void parse(){
   
   String[] lines = loadStrings(path);
   String[] firstline = split(lines[0], ",");
   
   String label = firstline[0];
   String value = firstline[1];
   // NEEDSWORK: fix-up constructors
   myPie  = new PieChart (label, value);
   myBar  = new BarChart (20, height*0.15);
   myLine = new LineChart(20, height*0.15);
   
   String[] row;
   float val;
   
   for(int i = 1; i < lines.length; i++){
     row = split(lines[i], ",");
     val = parseFloat(row[1]);
     
     myPie. addSlice(row[0], val);
     myLine.addDatum(row[0], val);
     myBar. addDatum(row[0], val);
   }
   myLine.setLinePoints();

   myBar.setPoints();
   myBar.setBarWid();
 }


 