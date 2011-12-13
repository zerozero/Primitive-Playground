package com.jonrowe.away3d.productFactory
{
	import com.jonrowe.away3d.productFactory.interfaces.IPrimitive;
	import com.jonrowe.away3d.productFactory.interfaces.IProductFactory;
	import com.jonrowe.away3d.productFactory.interfaces.IProductTypeMap;
	
	import flash.utils.Dictionary;
	
	
	public class ProductFactory implements IProductFactory
	{
		protected var productTypeMap : IProductTypeMap
		
		private static var PRODUCT_INVENTORY :Dictionary;
		
		public function ProductFactory( productTypeMap : IProductTypeMap )
		{
			this.productTypeMap = productTypeMap;
		}
		
		
		public function getProduct( type : String ) :IPrimitive
		{
			var ProductClass : Class = productTypeMap.getProductClass( type );
			var product :IPrimitive = new ProductClass;
			
			//create a new dictionary?
			if (!PRODUCT_INVENTORY)
				PRODUCT_INVENTORY  = new Dictionary();
			
			//create a new entry in the dict?
			if ( !PRODUCT_INVENTORY.hasOwnProperty(type) )
				PRODUCT_INVENTORY[type] = [];
			
			//keep a reference to the created product
			PRODUCT_INVENTORY[type].push( product ); 
			product.primitiveName = type +"_"+ PRODUCT_INVENTORY[type].length;
			return product; 
		}

	}
}