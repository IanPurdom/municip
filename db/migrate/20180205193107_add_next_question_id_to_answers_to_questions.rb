class AddNextQuestionIdToAnswersToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :answers_to_questions, :next_question_id, :integer
  end
end
