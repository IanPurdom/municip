class DropProgramToAnswers < ActiveRecord::Migration[5.1]
  def up
    drop_table :program_to_answers
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
