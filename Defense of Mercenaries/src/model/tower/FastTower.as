package model.tower
{
	
	import starling.display.Quad;
	import starling.display.Shape;
	import starling.events.Event;
	
	public class FastTower extends Tower
	{
		
		private static var towerShape:Quad = new Quad(GlobalState.tileSize, GlobalState.tileSize, 0xE01B6A, true);
		private var shape:Quad;
		
		
		public function FastTower()
		{
			super();
			
			super.attackInterval = 1000;
			super.range = GlobalState.tileSize * 4;
		}
		
		public override function init(e:Event):void
		{
			this.shape = new Quad(GlobalState.tileSize, GlobalState.tileSize, 0xE01B6A, true);
			addChild(shape);
		}
		
		public static function getGhost():Array
		{
			var ghostArray:Array = new Array(2);
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF0000, 0.3);
			shape.graphics.lineStyle(1, 0xFF0000, 0.7);
			shape.graphics.drawCircle(GlobalState.tileSize / 2, GlobalState.tileSize / 2, GlobalState.tileSize * 4);
			shape.graphics.endFill();
			ghostArray[0] = shape;
			
			var ghost:Quad = towerShape;
			ghost.alpha = 0.3;
			ghostArray[1] = ghost;
			
			return ghostArray;
		}
	}
}