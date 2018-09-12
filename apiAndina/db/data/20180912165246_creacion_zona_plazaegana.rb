class CreacionZonaPlazaegana < ActiveRecord::Migration[5.1]
  def up
	Zona.transaction do
  	execute <<-SQL
      	insert into zonas(name, geom, created_at,updated_at) values ('plaza_egaña', ST_Multi(ST_Polygon(ST_GeomFromText('LINESTRING(-70.5766 -33.4502,-70.5749 -33.4582,-70.5638 -33.4580,-70.5647 -33.4483,-70.5766 -33.4502)'), 4326)), NOW(),NOW())
  	SQL

	end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end