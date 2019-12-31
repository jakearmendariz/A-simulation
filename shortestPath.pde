/**
Jake Armendariz
ShowPath

Built in processing
Creates the canvas, calls the function

Instructions for use
When run:
The inital path is from the top left to bottom right
To change the unit size, see unit class

KeyCodes:
a = set starting point
z = set target pos
e = erase mode
c = clear map
else = addBlock

Path is immediatly found after every modifcation
What you see:
Gray is the closed set after search
Black is undiscoverd
White is the path
Red blocks the path (obstacles)

Credits:
Feel free to use this code for whatever you would like, you can give me credit but I copied a lot of Astar algorithm from Sebastian Lague
I will link his github and youtube tutorials
(This person coded it in C-sharp Unity instead of processing so code looks very different)
https://github.com/SebLague/Pathfinding
https://www.youtube.com/watch?v=mZfyt03LDH4&list=PLFt_AvWsXl0cq5Umv3pMC9SPnKjfp9eGW&index=3

The editor is all me along with modifications for it to run on processing
*/
Grid grid;//Main variable
int x,y;//Keeps track of mouse pressed and mouse released function
boolean erase;
int mode;
PVector start;
PVector target;
public void settings() { 
 size(800, 800);//Creates the canvas
}

void setup(){
   frameRate(2000);
   grid = new Grid();
   grid.clearMap();
   this.start = new PVector(0, 0);
   this.target = new PVector(height/grid.unit -1, width/grid.unit -1);
   grid.initPath(start, target);
   //grid.initPath(new PVector(0, 3), new PVector(39, 39));
   grid.clearMap();
   grid.Astar();
   erase = false;
   mode = 0;
}

void draw(){
  background(51);
  grid.display();
  
  int x = (int)mouseX/grid.unit;
  int y = (int)mouseY/grid.unit;
if (mousePressed == true) {
    if(mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height){
      if(mode == 1){
        grid.clearBlock(x, y);
      }
      else if(mode == 0){
        grid.addBlock(x, y);
      }
      if(mode == 2){
        start = new PVector(x, y);
        grid.initPath(start, target);
      }
      if(mode == 3){
        target = new PVector(x, y);
        grid.initPath(start, target);
      }
        grid.Astar();
    }
}
  //IF YOU WANT INSTRUCTIONS ON CANVAS
  //fill(255, 0, 0);
 // text("Click to add blocks", 30, 30);
  //text("Press 'e' to enter erase mode", 200, 30);
  //text("Press 'c' to clear map", 400, 30);
  // text("Press 'any other key exit erase", 570, 30);
  //text("Press 'a' to change starting point", 30, 100);
  //text("Press 'z' to change target pos", 200, 100);
}

void keyPressed(){
      
      int n = keyCode;
      if(keyCode == 65)
          mode = 2;
      else if(keyCode == 90)//If z -> mode 3, changing target pos
        mode = 3;
      else if(keyCode == 67)
         grid.clearMap();
      else if(keyCode == 69)
          mode = 1;
      else
        mode = 0;
}
