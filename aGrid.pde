/**
Jake Armendariz
Path Grid

Built with Processing
It has the ability to find the shortest path between startNode and targetNode
non-walkable nodes, assigned by addBlock are obstacles for A*
This implementation does not allow for diagnol jumps, it would be more efficient with diagnols
but I wanted this algorithm to work on the snake game.

Feel free to use this code for whatever you would like, you can give me credit but the real hero is Sebastian Lague
I will link his github and youtube tutorials
(This person coded it in C-sharp Unity instead of processing so code looks very different)
https://github.com/SebLague/Pathfinding
https://www.youtube.com/watch?v=mZfyt03LDH4&list=PLFt_AvWsXl0cq5Umv3pMC9SPnKjfp9eGW&index=3
*/
import java.util.concurrent.TimeUnit;
import java.util.*;
public class Grid {
 Node[][] grid;
 int columns, rows;
 Node startNode, targetNode;
 List <Node> openSet;
 List<Node> closedSet;
 List<Node> path;
 int unit;
 
 public Grid(){
   Node N = new Node(0, 0, true);//Just used for refernce for units
   this.columns = (int)width/N.unit;
   this.rows = (int)height/N.unit;
   this.unit = N.unit;
   
   grid = new Node[rows][columns];
   //System.out.println("Grid is " + rows + "x" + columns);
   for(int i = 0; i < rows; i ++){
        for(int j = 0; j < columns; j++){
          grid[i][j] = new Node(i, j, true);
        }
   }
   
   this.openSet = new ArrayList<Node>();
   this.closedSet = new ArrayList<Node>();
 }
 
 //Inititates a new Grid (not really, but allows the Astar algorithm to run again)
 public void initGrid(){
   this.openSet = new ArrayList<Node>();
   this.closedSet = new ArrayList<Node>(); 
   this.path = new ArrayList<Node>();
 }
 
 //Draws the color of nodes depending on their use
 //Black is the base map
 //white is the path
 //Maroon is the obstacle in the path
 //Blue is the open set
 //Gray is the closed set
 public void display(){
     for(int i = 0; i < rows; i ++){
        for(int j = 0; j < columns; j++){ 
           //noStroke();
           stroke(2);
           fill(30 + i, 30 + j, 30 + (i+j)/2);
           fill(10, 10, 10);
           Node N = grid[i][j];
           
           if(closedSet.contains(N)){
             fill(155, 155, 155); 
           }
           if(openSet.contains(N)){
             fill(55, 55, 155); 
           }
           if(this.path.contains(N)){
               fill(255, 255, 255); 
           }
           if(!N.isWalkable()){
             fill(100, 0, 0);
           }
           rect(N.x*N.unit, N.y*N.unit, N.unit, N.unit);
        }
     }
 }
 
 //Sets the start and target vector
 public void initPath(PVector start, PVector target){
    //System.out.println((int)target.x + ","+(int)target.y);
   if(start.x >= 0 && start.x < this.columns && start.y >= 0 && start.y < this.rows) {
     if(target.x >= 0 && target.x < this.rows && target.y >= 0 && target.y < this.columns) {
       this.startNode = this.grid[(int)start.x][(int)start.y];
       this.targetNode =  this.grid[(int)target.x][(int)target.y];
       return;
     }
   }
    System.out.println("Could not inititate path, start and target vectors are not within bounds");
 }
 
 
 
 //Adding a block makes the node unwalkable
 public void addBlock(int x, int y){
      grid[x][y].block();
 }
 
 public void clearMap(){
   for(int i = 0; i < rows; i ++){
        for(int j = 0; j < columns; j++){
          if(j < 0)
            grid[i][j].block();
          else
           grid[i][j].open();
        }
   }
   Astar();
   
 }
 
 public void clearBlock(int x, int y){
      grid[x][y].open();
 }
 
 //Unblocks
 public void freeBlock(int x, int y){
       grid[x][y].open();
 }
 
 /**
 A* path finder
 it finds the shortest path
 does not use diagnoals
 */
 public void Astar(){
   initGrid();
   openSet.add(startNode);
   Node currentNode;
   while(openSet.size() > 0){
     currentNode = openSet.get(0);
     for(int i = 1; i < openSet.size(); i++){
       if(currentNode.fCost() > openSet.get(i).fCost() || currentNode.fCost() == openSet.get(i).fCost() && currentNode.hCost > openSet.get(i).hCost){     
         currentNode = openSet.get(i);
       }
     }
     openSet.remove(currentNode);
     closedSet.add(currentNode);
     if(currentNode == targetNode){//There may be a problem here with these not being equal
        retracePath();
        return;//Path was found
     } 
     
     //boolean a = currentNode.isWalkable();
     List neighbors = getNeighbors(currentNode);
     for(int i = 0; i < neighbors.size(); i++){
        Node neighbor = (Node)neighbors.get(i);
        if(!neighbor.isWalkable() || closedSet.contains(neighbors.get(i))){
           continue;  
        }
        int newCostToNeighbor = getDistance(currentNode, neighbor) + currentNode.gCost;
        //May be a problem with this for loop bc I initialize gCost to be 0. But idk think so because it will be init first by open set
        if(newCostToNeighbor < neighbor.gCost|| !openSet.contains(neighbor)){
            neighbor.gCost = neighbor.gCost;
            neighbor.hCost = getDistance(neighbor, this.targetNode);
            neighbor.parent = currentNode;
            
            if(!openSet.contains(neighbor)){
              openSet.add(neighbor);
            }
        }
     }
   
   }
 }
 
 //Adds the path, allows us to display it
 void retracePath(){
   path = new ArrayList<Node>();
    Node currentNode = this.targetNode;
    while(currentNode != this.startNode){
       path.add(currentNode);
       currentNode = currentNode.parent;
    }
   path.add(currentNode);
   Collections.reverse(path);
 }
 //Distance between two nodes, used in A*
 int getDistance(Node start, Node end){
   int dstX = Math.abs(start.x - end.x);
   int dstY = Math.abs(start.y - end.y);
   
   return (dstX + dstY);
 }

 int getDistanceEuclidean(Node nodeA, Node nodeB) {
    int dstX = Math.abs(nodeA.x - nodeB.y);
    int dstY = Math.abs(nodeA.y - nodeB.x);

    if (dstX > dstY)
      return 14*dstY + 10* (dstX-dstY);
    return 14*dstX + 10 * (dstY-dstX);
  }
 
 //Gives the non-diagnoal neighbors
 public List<Node> getNeighbors(Node N){
   List<Node> neighbors = new ArrayList<Node>();
   int x = N.x;
   int y = N.y;
   if(x > 0)
       neighbors.add(grid[x-1][y]);
    if(x < rows-1)
       neighbors.add(grid[x+1][y]);
    if(y > 0)
       neighbors.add(grid[x][y-1]);
    if(y < columns-1)
       neighbors.add(grid[x][y+1]);
       
     return neighbors;
 }

 public List<Node> getNeighborsEuclidean(Node N){
   List<Node> neighbors = new ArrayList<Node>();
   int x = N.x;
   int y = N.y;
   for(int i = x-1; i <= x+1; i ++){
     for(int j = y-1; j <= y+1; j++){
       if(i > 0 && i < grid[0].length && j > 0 && j < grid.length){
         if(i != x || j != y){
             neighbors.add(grid[i][j]);
         }
       }
     }
   }
  
  
}