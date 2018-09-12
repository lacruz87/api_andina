class AddColorToCreatedZonas < ActiveRecord::Migration[5.1]
  def up
  	zonas=Zona.all
  	zonas.each do |zona|
  		zona.color="#FF0000"
  		zona.save
  	end

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end