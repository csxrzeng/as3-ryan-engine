package utils 
{
	/**
	 * ...
	 * @author xr.zeng
	 */
	public class DateUtil 
	{
		
		public function DateUtil() 
		{
			
		}
		
		/**
		 * 获取日期字符串20130125
		 * @param	date
		 * @return
		 */
		static public function getDateString(date:Date = null):String
		{
			if (!date)
			{
				date = new Date();
			}
			return "" + date.fullYear + (date.month + 1) + date.date;
		}
	}

}