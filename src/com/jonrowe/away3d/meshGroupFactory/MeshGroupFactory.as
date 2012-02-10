package com.jonrowe.away3d.meshGroupFactory
{
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupContainer3D;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupFactory;
	import com.jonrowe.away3d.meshGroupFactory.interfaces.IMeshGroupTypeMap;
	
	import flash.utils.Dictionary;
	
	
	public class MeshGroupFactory implements IMeshGroupFactory
	{
		protected var productTypeMap : IMeshGroupTypeMap
		
		private static var PRODUCT_INVENTORY :Dictionary;
		
		public function MeshGroupFactory( productTypeMap : IMeshGroupTypeMap )
		{
			this.productTypeMap = productTypeMap;
		}
		
		
		public function getProduct( type : String ) :IMeshGroupContainer3D
		{
			var ProductClass : Class = productTypeMap.getProductClass( type );
			
			if (ProductClass == null) throw new MeshGroupFactoryError(MeshGroupFactoryError.INSTANTIATION_ON_NON_CONSTRUCTOR_ERROR);
			var product :IMeshGroupContainer3D = new ProductClass;
			
			
			//create a new dictionary
			if (!PRODUCT_INVENTORY)
				PRODUCT_INVENTORY  = new Dictionary();
			
			//create a new entry in the dict
			if ( !PRODUCT_INVENTORY.hasOwnProperty(type) )
				PRODUCT_INVENTORY[type] = [];
			
			//keep a reference to the created product
			PRODUCT_INVENTORY[type].push( product );
			
			//create a unique name for the product (unique to this session only)
			product.primitiveName = type +"_"+ PRODUCT_INVENTORY[type].length;
			return product; 
		}

	}
	
}