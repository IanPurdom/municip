class AddAnswerToProgramToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_reference :program_to_answers, :answer, foreign_key: true
  end
end
