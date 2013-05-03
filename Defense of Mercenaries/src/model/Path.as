package model
{
	import flash.utils.ByteArray;
	
	public class Path
	{
		public static const NONE:int = 0, UP:int = 1, RIGHT:int = 2, DOWN:int = 3, LEFT:int = 4;
		
		private var directions:Array = null;
		
		public function Path()
		{
			directions = new Array();
		}
		
		public function copyPath(path:Path):Path
		{
			directions = path.getCopyOfDirections();
			
			return this;
		}
		
		public function getCopyOfDirections():Array
		{
			return directions.concat();
		}
		
		public function pushDirection(direction:int):void
		{
			directions.push(direction);
		}
		
		public function pop():int
		{
			return directions.pop();
		}
		
		public function popNextDirection():int
		{
			if (directions.length != 0)
				return directions.splice(0, 1)[0];
			else
				return NONE;
		}
	}
}