class CreacionDatosProductos < ActiveRecord::Migration[5.1]
  def up
  	p1=Product.create!({:sku => "111111", :desc => "Coca Cola Lata", :stock => 25000, :cjxpallet=> 50})
  	p2=Product.create!({:sku => "111235", :desc => "Sprite 1.5L", :stock => 35000, :cjxpallet=> 20})
  	p3=Product.create!({:sku => "111878", :desc => "Fanta 3.0L", :stock => 5000, :cjxpallet=> 30})
  	p4=Product.create!({:sku => "111987", :desc => "Coca Cola Zero 2.0L", :stock => 40000, :cjxpallet=> 18})
  	p4=Product.create!({:sku => "111985", :desc => "Coca Cola Light 2.0L", :stock => 45000, :cjxpallet=> 35})
  	p4=Product.create!({:sku => "111269", :desc => "Sprite Zero 2.0L", :stock => 20000, :cjxpallet=> 20})


  	 
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end