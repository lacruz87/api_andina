class Zona < ApplicationRecord
	include Featurable
	featurable :geom, [:name]

    def as_geojson
      sql = "SELECT ST_asgeojson(ST_Transform(ST_SetSRID(geom,4326),4326)) FROM Zonas where id = #{self.id};"

      cursor = Zona.connection.execute(sql)
      return cursor.first["st_asgeojson"]
    end
end
