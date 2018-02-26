class AddStatusToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :interviews, :status, foreign_key: true
  end
end
