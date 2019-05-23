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

class snake
{
    private int BLOCK_LENGTH;
    private int BLOCK_HEIGHT;
    private int BODY_SIZE;
    private int SPEED_FACTOR;
    
    ArrayList<position> snakePositions = new ArrayList<position>();
    
    public snake()
    {
        SPEED_FACTOR = 1;
        BODY_SIZE = 1;
        BLOCK_LENGTH = 10;
        BLOCK_HEIGHT = 10;
    }
}
