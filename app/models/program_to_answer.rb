class ProgramToAnswer < ApplicationRecord
  belongs_to :program
  belongs_to :answers_to_question
end
