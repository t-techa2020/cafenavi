class AddPrefectureToCafeposts < ActiveRecord::Migration[5.2]
  def change
    add_column :cafeposts, :prefecture, :integer
  end
end
