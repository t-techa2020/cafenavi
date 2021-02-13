class AddMapinfoToCafeposts < ActiveRecord::Migration[5.2]
  def change
    add_column :cafeposts, :address, :string
    add_column :cafeposts, :latitude, :float
    add_column :cafeposts, :longitude, :float
  end
end