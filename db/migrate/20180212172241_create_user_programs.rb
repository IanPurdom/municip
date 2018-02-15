class CreateUserPrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :user_programs do |t|
      t.text :program
      t.references :user, foreign_key: true
      t.references :interview, foreign_key: true
      t.references :question, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
