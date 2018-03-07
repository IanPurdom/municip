class DropAnswersTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :answers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
