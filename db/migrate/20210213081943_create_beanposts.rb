class CreateBeanposts < ActiveRecord::Migration[5.2]
  def change
    create_table :beanposts do |t|
      t.string :name
      t.string :image
      t.integer :amount
      t.integer :price
      t.string :country
      t.references :owner, foreign_key: true

      t.timestamps
    end
  end
end
