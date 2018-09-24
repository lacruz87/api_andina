class CreacionZonasDemo < ActiveRecord::Migration[5.1]
  def up
	Zona.transaction do
  	execute <<-SQL
      	insert into zonas(name, color, geom, created_at,updated_at) values ('andina_estacionamiento', '#f46b42', ST_Multi(ST_Polygon(ST_GeomFromText('LINESTRING(-70.7629 -33.3967,-70.7613 -33.3929,-70.7596 -33.3941,-70.7612 -33.3974,-70.7629 -33.3967)'), 4326)), NOW(),NOW())
  	SQL

	end

		Zona.transaction do
  	execute <<-SQL
      	insert into zonas(name, color, geom, created_at,updated_at) values ('andina_CD', '#f4e841', ST_Multi(ST_Polygon(ST_GeomFromText('LINESTRING(-70.7614 -33.3928,-70.7629 -33.3919,-70.7650 -33.3959,-70.7629 -33.3967,-70.7614 -33.3928)'), 4326)), NOW(),NOW())
  	SQL

	end

		Zona.transaction do
  	execute <<-SQL
      	insert into zonas(name, color, geom, created_at,updated_at) values ('andina_NO_Permitido', '#58f441', ST_Multi(ST_Polygon(ST_GeomFromText('LINESTRING(-70.7629 -33.3919,-70.7647 -33.3908,-70.7690 -33.3943,-70.7651 -33.3959,-70.7629 -33.3919)'), 4326)), NOW(),NOW())
  	SQL

	end

		Zona.transaction do
  	execute <<-SQL
      	insert into zonas(name, color, geom, created_at,updated_at) values ('exterior', '#58f441', ST_Multi(ST_Polygon(ST_GeomFromText('LINESTRING(-70.7632 -33.3895,-70.7655 -33.3882,-70.7743 -33.3960,-70.7714 -33.3970,-70.7686 -33.3949,-70.7644 -33.3975,-70.7626 -33.3971,-70.7694 -33.3943,-70.7632 -33.3895)'), 4326)), NOW(),NOW())
  	SQL

	end

	Zona.transaction do
  	execute <<-SQL
      	insert into zonas(name, color, geom, created_at,updated_at) values ('dpto_Waldo', '#f46b42', ST_Multi(ST_Polygon(ST_GeomFromText('LINESTRING(-70.6017 -33.4259,-70.6000 -33.4301,-70.5955 -33.4288,-70.5973 -33.4250,-70.6017 -33.4259)'), 4326)), NOW(),NOW())
  	SQL

	end

  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end