class CreateDeputies < ActiveRecord::Migration[5.1]
  def change
    create_table :deputies do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :title, null: false
      t.string :profession
      t.string :photo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
