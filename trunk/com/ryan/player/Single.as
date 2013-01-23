package com.ryan.player 
{
	/**
	 * 用于禁止外部创建对象
	 * @author xr.zeng
	 */
	internal class Single 
	{
		static public const instance:Single = new Single();
		
		public function Single() 
		{
			
		}
		
	}

}