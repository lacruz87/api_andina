class CreacionZonaAndina < ActiveRecord::Migration[5.1]
  def up

 

	Zona.transaction do
  	execute <<-SQL
      	insert into zonas(name, geom, created_at,updated_at) values ('andina', ST_Multi(ST_Polygon(ST_GeomFromText('LINESTRING(-70.7688 -33.3943,-70.7653 -33.3905,-70.7579 -33.3948,-70.7595 -33.3984, -70.7688 -33.3943)'), 4326)), NOW(),NOW())
  	SQL

	end

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end