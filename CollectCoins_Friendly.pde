/*
  Collect Coins Lab:
  
  Coins are placed randomly on the screen. Player moves around and collect coins.
  The number of coins is updated and displayed on the screen.
  There are two versions of this lab:
  1) Friendly Version. More helper code is provided in lab template.
  2) More Challenging Version. Less helper code is provided.
  
  This is the friendly version.
  For more detail, see the tutorial: https://youtu.be/RMmo3SktDJo
   
   
  Complete the code as indicated by the comments.
  Do the following:
  1) In setup, initialize arraylist of coins. Then use a loop to create coin Sprites and placed them
  randomly on the screen. Add each coin to arraylist.
  2) In draw, for loop to display each coin. 
  3) Now, implement checkCollision and checkCollisionList. (in the video above, I wrote the code for these methods) 
  4) In draw, call checkCollisionList with parameters player and list of coins to get collision list.
  Loop through collision list and remove them and update score. 
  5) In draw, display score using textSize(), fill() and text().
  
  See the comments below for more details. 
 
*/

final static float MOVE_SPEED = 4;
final static float COIN_SCALE = 0.4;
final static float TANK_SCALE = 0.8;


Sprite player;
ArrayList<Sprite> coins; 
ArrayList<Sprite> remains;
int score;

void setup(){
  size(1024, 768);
  imageMode(CENTER);
  player = new Sprite("tank.png", TANK_SCALE, width/2, height/2);

  // initialize score
  score = 0;
  // initialize the arrayList coins
  coins = new ArrayList<Sprite>();
  remains = new ArrayList<Sprite>();
  // for loop to create coin Sprite and add to coins arraylist
  // randomize their center_x and center_y(use MATH.random() and cast to float)
  for (int i = 0; i < 50; i++){
    Sprite coin = new Sprite("ukraine.png", COIN_SCALE);
    coin.center_x = (float)(Math.random()*width);
    coin.center_y = (float)(Math.random()*height);
    coins.add(coin);
  }
  
}

void draw(){
  background(255);
  for (Sprite coin : coins)
    coin.display();
   for (Sprite remain: remains)
     remain.display();
     
  player.display();
  player.update();
  
  // use for each loop to display coins

  
  
  // call checkCollisionList and 
  // store the returned collision list(arraylist) of coin Sprites that collide with player.
  // if collision list not empty
  //   for loop through collision list
  //     remove each coin, add 1 to score
  ArrayList<Sprite> collision_list = checkCollisionList(player, coins);
  if(collision_list.size() > 0){
    // fill in for loop through collision list
    // remove each coin and add 1 to score
    for (Sprite s : collision_list)
    {
      Sprite remain = new Sprite("explode.png", COIN_SCALE);
      remain.center_x = s.center_x;
      remain.center_y = s.center_y;
      coins.remove(s);
      remains.add(remain);
      score++;
    }
  }
  
  // call textSize(size), fill(r, g, b) and text(str, x, y) to display score. 
  textSize(32);
  fill(255, 0, 0);
  text("Ukraines Conquered:" + score, 50, 50);
}

// returns whether the two Sprites s1 and s2 collide.
public boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  }
  else{
    return true;
  }
}

/**
   This method accepts a Sprite s and an ArrayList of Sprites and returns
   the collision list(ArrayList) which consists of the Sprites that collide with the given Sprite. 
   MUST CALL THE METHOD checkCollision ABOVE!
*/ 
public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  // fill in code here
  // see: https://youtu.be/RMmo3SktDJo
  ArrayList<Sprite> collisionList = new ArrayList<Sprite>();
  for (Sprite p : list)
  {
     if (checkCollision(s,p))
       collisionList.add(p);
  }
  return collisionList;
}


  
void keyPressed(){
  if(keyCode == RIGHT)
    player.change_x = MOVE_SPEED;
  else if(keyCode == LEFT)
    player.change_x = -MOVE_SPEED;
  else if(keyCode == UP)
    player.change_y = -MOVE_SPEED;
  else if(keyCode == DOWN)
    player.change_y = MOVE_SPEED;
}

void keyReleased(){
  if(keyCode == RIGHT)
    player.change_x = 0;
  else if(keyCode == LEFT)
    player.change_x = 0;
  else if(keyCode == UP)
    player.change_y = 0;
  else if(keyCode == DOWN)
    player.change_y = 0;
    
}
