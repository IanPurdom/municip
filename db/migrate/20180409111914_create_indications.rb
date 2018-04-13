class CreateIndications < ActiveRecord::Migration[5.1]
  def change
    create_table :indications do |t|
      t.text :indication
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
