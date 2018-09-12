class AddColorToZona < ActiveRecord::Migration[5.1]
  def change
    add_column :zonas, :color, :string
  end
end
