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

puts "creating questionnaire..."

category = Category.find_by(name: "Sécurité")
questionnaire = Questionnaire.create(title: "le constat sur la ville", category: category, root_question_id: 1)

puts "creating interview..."

interview = Interview.create(user: user, questionnaire: questionnaire)

puts "creating answers..."

yes = Answer.create(answer: "Oui")
no = Answer.create(answer: "Non")

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

question_ids = []
questions.each do |question|
  q = Question.create(question)
  question_ids << q.id
  # p question_ids
end

puts "creating answers_to_questions..."

aq_0 = AnswersToQuestion.create(question_id: question_ids[0], answer_id: yes.id, next_question_id: question_ids[1])
aq_1 = AnswersToQuestion.create(question_id: question_ids[0], answer_id: no.id)
aq_2 = AnswersToQuestion.create(question_id: question_ids[1], answer_id: yes.id, next_question_id: question_ids[2])
aq_3 = AnswersToQuestion.create(question_id: question_ids[2], answer_id: yes.id)

aq_4 = AnswersToQuestion.create(question_id: question_ids[1], answer_id: no.id)
aq_5 = AnswersToQuestion.create(question_id: question_ids[2], answer_id: no.id)

atq = [aq_0.id, aq_1.id, aq_2.id, aq_3.id]
# p atq

puts "creating program_to_answers..."

for i in 0..3
# p i
pta = ProgramToAnswer.new(answers_to_question_id: atq[i], program_id: program_ids[i])
pta.save
# p pta
i+=1
end

puts "seeds done"
