/**
Jake Armendariz
Unit
Contains the Node class
The entire graph consists of units, either walkable or not with distance from target and base
*/
public class Node {
  public int x, y;
  public int hCost, gCost;
  public boolean walkable;
  public Node parent;
  public int heapIndex;
  public int unit = 20;
  
  public Node(int _x, int _y, boolean isWalkable){
    this.x = _x;
    this.y = _y;
    this.walkable = isWalkable;
    this.hCost = 0;
    this.gCost = 0;
    this.parent = null;
  }
  
  
  
  public int fCost(){
    return this.hCost = this.gCost;
  }
  
  public void block(){
     this.walkable = false;
  }
  
  public void open(){
     this.walkable = true;
  }
  
  public boolean isWalkable(){
    return this.walkable;
  }
   
   void displayText(){
     textSize(8);
     fill(255);
     text(fCost(), x*20, y*20);
   }
}