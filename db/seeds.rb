puts "cleaning seeds..."


UserProgram.destroy_all
Program.destroy_all
Interview.destroy_all
Question.destroy_all
Questionnaire.destroy_all
Interview.destroy_all
Category.destroy_all
Answer.destroy_all
User.destroy_all

puts "creating seeds..."

puts "creating users..."
user = User.new(first_name: "Charles", last_name: "Bazin", email: "charles@mail.com", photo: "image/upload/v1515578859/q38jatr8rzd673e61tu4.jpg", password: '123456')
user.photo = Rails.root.join("db/images/#{user.first_name}_#{user.last_name}.jpg").open
user.save!

puts "creating deputies..."

deputies = [
{ first_name: "Laurent",
  last_name: "Dugenoux",
  title: "Adjoint aux finances",
  profession: "Expert comptable",
  user: User.last
},
{ first_name: "Patrick",
  last_name: "François",
  title: "Adjoint à la sécurité",
  profession: "Consultant",
  user: User.last
},
{ first_name: "Franck",
  last_name: "Duchemin",
  title: "Adjoint à l'urbanisme",
  profession: "Architecte",
  user: User.last
}
]

deputies.each_with_index do |deputy|
  new_deputy = Deputy.new(deputy)
  new_deputy.photo =  Rails.root.join("db/images/#{new_deputy.last_name}.jpeg").open
  new_deputy.save
end

puts "creating city..."

new_city = City.new(
  zip_code: "27130",
  departement: "l'Eure",
  region: "Normandie",
  intercommunalite: "Communauté de communes Normandie Sud Eure",
  population: "320",
  density: "25",
  debt: nil,
  current_maire: "Philippe Obadia",
  name: "Les Barils"
)
new_city.user = User.find_by(first_name: "Charles")
new_city.save

puts "creating city's photos..."


for i in 1..4
picture = Photo.new(city_id: new_city[:id])
picture.photo = Rails.root.join("db/images/mairie_#{i}.jpg").open
picture.save
# p picture
end

puts "creating categories..."

categories = ["Finance", "Urbanisme", "Sécurité"]

categories.each do |category|
  Category.create!(name: category)
end

puts "creating programs & categories..."
file = "db/programs.yml"
programs = YAML.load(open(file).read)

program_ids = []
# n = 0
programs["programs"].each do |program|
  # Category.create!(categories[n])
  u = Program.new(program)
  u.category = Category.find_by(name: "Sécurité")
  u.save
  # n += 1
  program_ids << u.id
  # p program_ids
end


file = "db/programs_2.yml"
programs_2 = YAML.load(open(file).read)

program_2_ids = []
# n = 0
programs_2["programs"].each do |program|
  # Category.create!(categories[n])
  u = Program.new(program)
  u.category = Category.find_by(name: "Sécurité")
  u.save
  # n += 1
  program_2_ids << u.id
  # p program_ids
end


file = "db/programs_3.yml"
programs_3 = YAML.load(open(file).read)

program_3_ids = []
# n = 0
programs_3["programs"].each do |program|
  # Category.create!(categories[n])
  u = Program.new(program)
  u.category = Category.find_by(name: "Sécurité")
  u.save
  # n += 1
  program_3_ids << u.id
  # p program_ids
end


puts "creating status.."

Status.create(status: "in_progress")
Status.create(status: "done")

puts "creating answers..."

yes = Answer.create(answer: "Oui")
no = Answer.create(answer: "Non")
ville = Answer.create(answer: "Délinquance issue de la ville")
transit = Answer.create(answer: "Délinquance de transit")
deux = Answer.create(answer: "Les deux")

puts "creating questionnaires..."

category = Category.find_by(name: "Sécurité")
questionnaire = Questionnaire.create(title: "Le constat sur la ville", category: category, root_question_id: 1)
questionnaire_2 = Questionnaire.create(title: "Bilan de l’action municipale passée", category: category, root_question_id: 1)
questionnaire_3 = Questionnaire.create(title: "Analyse de la délinquance", category: category, root_question_id: 1)

# puts "creating interview..."

# interview = Interview.create(user: user, questionnaire: questionnaire)

puts "creating questions..."

questions = [
  {question:"Diriez-vous que votre commune connait des problèmes d’insécurité ?",
   questionnaire: questionnaire
  },
  {question:"Disposez-vous de chiffres concernant la délinquance dans votre commune ?",
   questionnaire: questionnaire
  },
  {question:"La délinquance est-elle plus forte que dans les autres communes ?",
   questionnaire: questionnaire
  }
]


questions_2 = [
  {question:"Les municipalités précédentes ont-elles agit pour éradiquer la délinquance ?",
   questionnaire: questionnaire_2
  },
  {question:"La sécurité est-elle une préoccupation  autour des établissements scolaires ?",
   questionnaire: questionnaire_2
  },
  {question:"La sécurité est-elle une préoccupation  dans les transports ?",
   questionnaire: questionnaire_2
  }
]

questions_3 = [
  {question:"La délinquance est-elle une délinquance issue de la ville ou une délinquance de transit ?",
   questionnaire: questionnaire_3
  }
]


question_ids = []
questions.each do |question|
  q = Question.create(question)
  question_ids << q.id
  # p question_ids
end

question_2_ids = []
questions_2.each do |question|
  q = Question.create(question)
  question_2_ids << q.id
  # p question_ids
end


question_3_ids = []
questions_3.each do |question|
  q = Question.create(question)
  question_3_ids << q.id
  # p question_ids
end


puts "creating answers_to_questions for questionnaire 1..."

aq_0 = AnswersToQuestion.create(question_id: question_ids[0], answer_id: yes.id, next_question_id: question_ids[1])
aq_1 = AnswersToQuestion.create(question_id: question_ids[0], answer_id: no.id)
aq_2 = AnswersToQuestion.create(question_id: question_ids[1], answer_id: yes.id, next_question_id: question_ids[2])
aq_3 = AnswersToQuestion.create(question_id: question_ids[2], answer_id: yes.id)

aq_4 = AnswersToQuestion.create(question_id: question_ids[2], answer_id: no.id)
aq_5 = AnswersToQuestion.create(question_id: question_ids[1], answer_id: no.id)

atq = [aq_0.id, aq_1.id, aq_2.id, aq_3.id]
atq_no_prog = [aq_4.id, aq_5.id]

puts "creating program_to_answers for questionnaire..."

for i in 0..3
# p i
pta = ProgramToAnswer.new(answers_to_question_id: atq[i], program_id: program_ids[i])
pta.save
# p pta
i+=1
end

#for the one using the no_program // program_id => program.yml the last one i.e program_ids[4] !
for i in 0..1
pta_no_prog = ProgramToAnswer.new(answers_to_question_id: atq_no_prog[i], program_id:program_ids[4] )
pta_no_prog.save
# p pta
i+=1
end

puts "creating answers_to_questions for questionnaire 2..."

aq_2_0 = AnswersToQuestion.create(question_id: question_2_ids[0], answer_id: yes.id, next_question_id: question_2_ids[1])
aq_2_1 = AnswersToQuestion.create(question_id: question_2_ids[0], answer_id: no.id, next_question_id: question_2_ids[1])
aq_2_2 = AnswersToQuestion.create(question_id: question_2_ids[1], answer_id: yes.id, next_question_id: question_2_ids[2])
aq_2_3 = AnswersToQuestion.create(question_id: question_2_ids[2], answer_id: yes.id)


aq_2_4 = AnswersToQuestion.create(question_id: question_2_ids[1], answer_id: no.id, next_question_id: question_2_ids[2])
aq_2_5 = AnswersToQuestion.create(question_id: question_2_ids[2], answer_id: no.id)

atq_2 = [aq_2_0.id, aq_2_1.id, aq_2_2.id, aq_2_3.id]
atq_2_no_prog = [aq_2_4.id, aq_2_5.id]

puts "creating program_to_answers for questionnaire_2..."

for i in 0..3
# p i
pta_2 = ProgramToAnswer.new(answers_to_question_id: atq_2[i], program_id: program_2_ids[i])
pta_2.save
# p pta
i+=1
end

#for the one using the no_program // program_id => program.yml the last one i.e program_ids[4] !
for i in 0..1
pta_2_no_prog = ProgramToAnswer.new(answers_to_question_id: atq_2_no_prog[i], program_id:program_2_ids[4] )
pta_2_no_prog.save
# p pta
i+=1
end

puts "creating answers_to_questions for questionnaire 3..."

aq_3_0 = AnswersToQuestion.create(question_id: question_3_ids[0], answer_id: ville.id)
aq_3_1 = AnswersToQuestion.create(question_id: question_3_ids[0], answer_id: transit.id)
aq_3_2 = AnswersToQuestion.create(question_id: question_3_ids[0], answer_id: deux.id)

atq_3 = [aq_3_0.id, aq_3_1.id, aq_3_2.id]

puts "creating program_to_answers for questionnaire_3..."

for i in 0..3
# p i
pta_3 = ProgramToAnswer.new(answers_to_question_id: atq_3[i], program_id: program_3_ids[i])
pta_3.save
# p pta
i+=1
end



puts "seeds done"
