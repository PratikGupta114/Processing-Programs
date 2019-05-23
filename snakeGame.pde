
/* THE ETERNAL SNAKE !!
 * Created on 23rd May (saal jaanke kya karoge ?)
 * Author - Pratik Gupta B-)
 * The purpose of this project is absolutely nothing but still under development.
 * If you want to add some features into the game, you're absolutely welcome.
 * The variable nomenclature is pretty lame !!
 */
 
 
class position
{
    private int X_COORDINATE;
    private int Y_COORDINATE;
    
    public position(int x, int y)
    {
        this.X_COORDINATE = x;
        this.Y_COORDINATE = y;
    }
    public position(int x)
    {
        this.X_COORDINATE = x;
        this.Y_COORDINATE = x;
    }
    public position()
    {
        this.X_COORDINATE = 0;
        this.Y_COORDINATE = 0;
    }
    
    public int getXcoordinate()
    {
      return this.X_COORDINATE;
    }
    
    public int getYcoordinate()
    {
      return this.Y_COORDINATE;
    }
}

class Snake
{
    private int BLOCK_LENGTH;
    private int BLOCK_HEIGHT;
    private int SNAKE_LENGTH;
    private int SPEED_FACTOR;
    private char SNAKE_DIRECTION = 'R';
    private position HEAD_POSITION = new position(width/2,width/2);
    private position FOOD_POSITION = new position(200,200);
    
    ArrayList<position> snakePositions = new ArrayList<position>();
        
    public Snake()
    {
        SPEED_FACTOR = 1;
        SNAKE_LENGTH = 1;
        BLOCK_LENGTH = 10;
        BLOCK_HEIGHT = 10;
        SNAKE_DIRECTION = 'R';
        this.snakePositions.add(HEAD_POSITION);
    }
    
    // setter methods 
    public void setSpeedFactor(int speed_factor)
    {
        this.SPEED_FACTOR = speed_factor;
    }
    public void setBlockDimension(int x, int y)
    {
        this.BLOCK_LENGTH = x;
        this.BLOCK_HEIGHT = y;
    }
    public void setSnakeLength(int snake_length)
    {
        this.SNAKE_LENGTH = snake_length;
    }
    public void setSnakeDirection(char direction)
    {
        this.SNAKE_DIRECTION = direction;
    }
    public void setSnakePosition(int x, int y)
    {
        this.HEAD_POSITION.X_COORDINATE = x;
        this.HEAD_POSITION.Y_COORDINATE = y;
    }
    public void setNewFoodPosition()
    {
        this.FOOD_POSITION = this.findNewFoodCoordinates();
    }
    
    // getter methods
    public char getSnakeDirection()
    {
        return this.SNAKE_DIRECTION;
    }
    public int getSpeedFactor()
    {
        return this.SPEED_FACTOR;
    }
    public int getSnakeLength()
    {
        return this.SNAKE_LENGTH ; 
    }
    public position getCurrentSnakePosition()
    {
        return this.HEAD_POSITION;
    }
    public position getFoodPosition()
    {
        return this.FOOD_POSITION;
    }
    public int getBlockLength()
    {
        return this.BLOCK_LENGTH;
    }
    public int getBlockHeight()
    {
        return this.BLOCK_HEIGHT;
    }
    public position findNewFoodCoordinates()
    {
        int x = (int)random(0 , (float)(width/this.SPEED_FACTOR));
        int y = (int)random(0 , (float)(height/this.SPEED_FACTOR));
        
        position randomFoodCoordinate = new position(x * this.SPEED_FACTOR , y * this.SPEED_FACTOR);
        return randomFoodCoordinate;
    }
    
    // major functions
    public void upgradePosition()
    {
        for(int i = SNAKE_LENGTH - 2 ; i >= 0 ; i--)
        {
            snakePositions.get(i+1).X_COORDINATE = snakePositions.get(i).X_COORDINATE;
            snakePositions.get(i+1).Y_COORDINATE = snakePositions.get(i).Y_COORDINATE;
        }
        snakePositions.get(0).X_COORDINATE = HEAD_POSITION.X_COORDINATE;
        snakePositions.get(0).Y_COORDINATE = HEAD_POSITION.Y_COORDINATE;
    }
    public void drawSnake()
    {
        for(int i = 0 ; i < SNAKE_LENGTH ; i++)
        {
            stroke(255);
            fill(255);
            rect(this.snakePositions.get(i).X_COORDINATE , this.snakePositions.get(i).Y_COORDINATE , this.BLOCK_LENGTH , this.BLOCK_HEIGHT , 2);
        }
    }
    public boolean hasEatenFood()
    {
        int foodx = this.HEAD_POSITION.X_COORDINATE;
        int foody = this.HEAD_POSITION.Y_COORDINATE;
        int snakex = this.FOOD_POSITION.X_COORDINATE;
        int snakey = this.FOOD_POSITION.Y_COORDINATE;
        
        if(  dist(foodx,foody,snakex,snakey) <= (float)(snake.getBlockLength()/2) )
          return true;
        else
          return false;
    }
    public void grow()
    {
       this.SNAKE_LENGTH += 1;
       position newPosition = new position();
       this.snakePositions.add(newPosition);
       upgradePosition();
    }
    public void move()
    {
        switch(SNAKE_DIRECTION)
        {
            case 'U' :
            {
                this.HEAD_POSITION.Y_COORDINATE -= this.SPEED_FACTOR ;
                this.upgradePosition();
            }
            break;
            case 'D' :
            {
                this.HEAD_POSITION.Y_COORDINATE += this.SPEED_FACTOR ;
                this.upgradePosition();
            }
            break;
            case 'L' :
            {
                this.HEAD_POSITION.X_COORDINATE -= this.SPEED_FACTOR ;
                this.upgradePosition();
            }
            break;
            case 'R' :
            {
                this.HEAD_POSITION.X_COORDINATE += this.SPEED_FACTOR ;
                this.upgradePosition();
            }
            break;
            default :
            {  /*default code*/  }
            break;
        }
    }
    
}

// A global reference to to the snake object xD
Snake snake;

// initialization and stuffs
void setup()
{
    frameRate(60);
    
    size(1800,1000);
    snake = new Snake();
    
    snake.setBlockDimension(15,15);
    snake.setSpeedFactor(5);
    snake.setSnakeDirection('D');
    snake.setSnakePosition(900,500);
    snake.setNewFoodPosition();
}

// void draw runs continuously, analogous to void loop in arduino
void draw()
{
      clear();
      background(61,126,150);
      // Draw the food box randomly anywhere on the screen
      stroke(255,125,125);
      fill(255,125,125);
      rect( snake.getFoodPosition().X_COORDINATE , snake.getFoodPosition().Y_COORDINATE , snake.getBlockLength() , snake.getBlockHeight() , 2);
      if(snake.hasEatenFood())
      {
          snake.grow();
          snake.setNewFoodPosition();
      }
      snake.move();
      snake.drawSnake();
      delay(10);
}

// on keypress 
void keyPressed()
{
    if(key == CODED)
    {
        switch(keyCode)
        {
            case UP :
            {
                if(snake.getSnakeDirection() != 'D')
                    snake.setSnakeDirection('U');
            }
            break;
            case DOWN :
            {
                if(snake.getSnakeDirection() != 'U')
                    snake.setSnakeDirection('D');
            }
            break;
            case LEFT :
            {
                if(snake.getSnakeDirection() != 'R')
                    snake.setSnakeDirection('L');
            }
            break;
            case RIGHT :
            {
                if(snake.getSnakeDirection() != 'L')
                    snake.setSnakeDirection('R');
            }
            break;
            default :
            {  /* default code */  }
            break;
        }
    }
}
