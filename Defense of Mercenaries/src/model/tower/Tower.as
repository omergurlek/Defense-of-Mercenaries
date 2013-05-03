package model.tower
{
	import flash.geom.Point;
	
	import model.Path;
	import model.GameObject;
	import model.Occupier;
	import model.enemy.Enemy;
	import model.tile.Tile;
	
	import starling.display.Quad;
	import starling.events.Event;
	import model.projectile.Projectile;
	
	public class Tower extends Occupier implements GameObject
	{
		private var level:int;
		private var position:Tile;
		private var purchaseCost:int;
		private var upgradeModifier:int;
		private var damage:int = 20;
		private var range:int;
		private var influenceRange:int;
		private var shape:Quad; //Placeholder graphics variable
		private var attackInterval:int = 1000;
		private var currentInterval:int = 0;
		
		public function Tower()
		{
			super();
			
			this.level = 1;
									
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
				
		public override function init(e:Event):void
		{			
			this.shape = new Quad(Settings.tileSize, Settings.tileSize, 0x7A4F2C, true);
			addChild(shape);
		}

		public function update(deltaTime:Number):void
		{
			currentInterval += deltaTime;
			
			if (currentInterval > attackInterval)
			{	
				findFirstEnemy();
				currentInterval -= attackInterval;
			}
		}
		
		private function findFirstEnemy():void
		{
			for (var i:int = 0; i < Settings.currentMap.numChildren; i++)
			{
				var child:Object = Settings.currentMap.getChildAt(i);
				
				if (child is Enemy){
					shoot(child as Enemy);
					break;
				}
			}
		}
		
		public function shoot(enemy:Enemy):void
		{
			var bullet:Projectile = new Projectile(enemy, 10, damage, this);
			bullet.x = x + Settings.tileSize / 2;
			bullet.y = y + Settings.tileSize / 2;
			Settings.currentMap.addChild(bullet);
		}
		
		// Placeholder upgrade cost calculation
		private function getUpgradeCost(level:int):int
		{
			return (upgradeModifier * level);
		}
	}
}