class AddStatusToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :answers, :status, foreign_key: true
  end
end
