class CreateZonas < ActiveRecord::Migration[5.1]
  def change
    create_table :zonas do |t|
      t.string :name
      t.multi_polygon :geom, :srid => 4326

      t.timestamps
    end

	change_table :zonas do |t|
  		t.index :geom, using: :gist
	end

  end
end
