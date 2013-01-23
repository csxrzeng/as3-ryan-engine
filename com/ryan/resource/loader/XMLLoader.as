package com.ryan.resource.loader
{
	import flash.utils.ByteArray;

	public class XMLLoader extends BaseLoader
	{
		private var _valid:Boolean = true;
		private var _xml:XML = null;

		/**
		 * The loaded XML. This will be null until loading of the resource has completed.
		 */
		public function get XMLData():XML
		{
			return _xml;
		}

		override public function getClass():Class
		{
			return XMLLoader;
		}

		/**
		 * The data loaded from an XML file is just a string containing the xml itself,
		 * so we don't need any special loading. This just converts the byte array to
		 * a string and marks the resource as loaded.
		 */
		override public function initialize(data:*):void
		{
			if (!(data is ByteArray))
				throw new Error("XMLResource can only initialize from ByteArrays.");
			try
			{
				_xml = new XML(data.toString());
				if (resourceInfo)
				{
					resourceInfo.data = _xml;
				}
			}
			catch (e:TypeError)
			{
				_valid = false;
			}
			onLoadCompleteHandler();
		}

		/**
		 * @inheritDoc
		 */
		override protected function onContentReady(content:*):Boolean
		{
			return _valid;
		}
	}
}
