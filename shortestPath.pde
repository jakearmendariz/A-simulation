/**
Jake Armendariz
ShowPath

Built in processing
Creates the canvas, calls the function

Instructions for use
When run:
The inital path is from the top left to bottom right
If you would like to change that is inside of setup initpath

If you would like to add obstacles, you can click individual nodes, or drag for larger areas
The path will adjust immediately

Credits:
Feel free to use this code for whatever you would like, you can give me credit but I copied a lot from Sebastian Lague
I will link his github and youtube tutorials
(This person coded it in C-sharp Unity instead of processing so code looks very different)
https://github.com/SebLague/Pathfinding
https://www.youtube.com/watch?v=mZfyt03LDH4&list=PLFt_AvWsXl0cq5Umv3pMC9SPnKjfp9eGW&index=3
*/
Grid grid;//Main variable
int x,y;//Keeps track of mouse pressed and mouse released function
public void settings() { 
 size(800, 800);//Creates the canvas
}

void setup(){
   frameRate(12);
   grid = new Grid();
   grid.initPath(new PVector(0, 0), new PVector(39, 39));
   grid.Astar();
}

void draw(){
  
  background(51);
  grid.display();
  
}

void keyPressed(){
      int n = keyCode;
}

void mouseClicked(){
  int x = (int)mouseX/20;
  int y = (int)mouseY/20;
  grid.addBlock(x, y);
  grid.Astar();
  
}

void mousePressed(){
   x = mouseX;
   y = mouseY;
}

void mouseReleased(){
  int xFrom = (int)Math.min(x, mouseX)/20;
  int xTo = (int)Math.max(x, mouseX)/20;
  
  int yFrom = (int)Math.min(y, mouseY)/20;
  int yTo = (int)Math.max(y, mouseY)/20;
  
  for(int i = xFrom; i <= xTo; i++){
      for(int j = yFrom; j <= yTo; j++){
         grid.addBlock(i, j);
      }
  }
  grid.Astar();
}
