class CreateOwners < ActiveRecord::Migration[5.2]
  def change
    create_table :owners do |t|
      t.string :cafename
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
