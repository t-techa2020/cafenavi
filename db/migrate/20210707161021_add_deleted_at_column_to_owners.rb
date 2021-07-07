class AddDeletedAtColumnToOwners < ActiveRecord::Migration[5.2]
  def change
    add_column :owners, :deleted_at, :datetime
  end
end
