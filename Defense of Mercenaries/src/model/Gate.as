package model
{
  import starling.display.Sprite;

  public class Gate extends Sprite implements GameObject
  {
    private var spawnQueue:Array = null;

    public function Gate()
    {
      super();
    }
	
	public override function update(dt:Number)
	{
		// TODO: Spawning.
	}
  }
}
