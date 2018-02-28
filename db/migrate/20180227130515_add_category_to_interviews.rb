class AddCategoryToInterviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :interviews, :category, foreign_key: true
  end
end
