class AddNameToCafeposts < ActiveRecord::Migration[5.2]
  def change
    add_column :cafeposts, :name, :string
  end
end
