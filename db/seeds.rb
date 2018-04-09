puts "cleaning seeds..."

UserProgram.destroy_all
Program.destroy_all
Answer.destroy_all
Interview.destroy_all
Status.destroy_all
Question.destroy_all
Questionnaire.destroy_all
Deputy.destroy_all
Photo.destroy_all
Category.destroy_all
User.destroy_all
Role.destroy_all

puts "creating seeds..."

puts "creating categories..."

categories = ["Finance", "Urbanisme", "Sécurité"]

categories.each do |category|
  Category.create!(name: category)
end

puts "creating roles"
Role.create(role:"user")
Role.create(role:"master")


puts "creating users..."
user = User.new(first_name: "Charles", last_name: "Bazin", email: "charles@mail.com", photo: "image/upload/v1515578859/q38jatr8rzd673e61tu4.jpg", password: '123456')
user.photo = Rails.root.join("db/images/#{user.first_name}_#{user.last_name}.jpg").open
user.save!

user2 = User.new(first_name: "Philippe", last_name: "Olivier", email: "philippe@mail.com", password: '123456', role: Role.find_by(role:"master"))
user2.save!


# puts "creating deputies..."

# deputies = [
# { first_name: "Laurent",
#   last_name: "Dugenoux",
#   title: "Adjoint aux finances",
#   profession: "Expert comptable",
#   user: User.last,
#   category: Category.find_by(name: "Finance"),
#   family: "marié",
#   address: "113 rue du Chateau, les Barils 27130",
#   description: "Fonctions électives à la Ville :
#     Elu conseiller le 18 mars 2001, réélu le 16 mars 2008 et le 30 mars 2014
#     Elu conseiller métropolitain le 15 décembre 2015
#     Elu adjoint à la Maire, le 6 octobre 2017, chargé de toutes les questions relatives aux Sociétés d'économie mixte et aux sociétés publiques locales
#     Président du groupe Radical de Gauche, Centre et Indépendants
#     Elu adjoint au Maire, le 21 mars 2008, chargé du tourisme et des nouveaux médias locaux (Mandature 2008-2014)
#     Elu adjoint au Maire, le 18 mars 2001, chargé du tourisme (mandature 2001-2008)
#     Fonctions électives dans son arrondissement :
#     Représentations :
#     Président du Conseil d'Administration de la Société anonyme d’économie mixte de la gare routière de Rungis (SOGARIS)
#     Autres mandats :
#     Président de la fédération de Paris du parti radical
#     Trésorier du parti radical"
# },
# { first_name: "Patrick",
#   last_name: "François",
#   title: "Adjoint à la sécurité",
#   profession: "Consultant",
#   user: User.last,
#   category: Category.find_by(name: "Sécurité"),
#   family: "marié",
#   address: "113 rue du Chateau, les Barils 27130",
#   description: "Fonctions électives à la Ville :
#     Elu conseiller le 18 mars 2001, réélu le 16 mars 2008 et le 30 mars 2014
#     Elu conseiller métropolitain le 15 décembre 2015
#     Elu adjoint à la Maire, le 6 octobre 2017, chargé de toutes les questions relatives aux Sociétés d'économie mixte et aux sociétés publiques locales
#     Président du groupe Radical de Gauche, Centre et Indépendants
#     Elu adjoint au Maire, le 21 mars 2008, chargé du tourisme et des nouveaux médias locaux (Mandature 2008-2014)
#     Elu adjoint au Maire, le 18 mars 2001, chargé du tourisme (mandature 2001-2008)
#     Fonctions électives dans son arrondissement :
#     Représentations :
#     Président du Conseil d'Administration de la Société anonyme d’économie mixte de la gare routière de Rungis (SOGARIS)
#     Autres mandats :
#     Président de la fédération de Paris du parti radical
#     Trésorier du parti radical"
# },
# { first_name: "Franck",
#   last_name: "Duchemin",
#   title: "Adjoint à l'urbanisme",
#   profession: "Architecte",
#   user: User.last,
#   category: Category.find_by(name: "Urbanisme"),
#   family: "marié",
#   address: "113 rue du Chateau, les Barils 27130",
#   description: "Fonctions électives à la Ville :
#     Elu conseiller le 18 mars 2001, réélu le 16 mars 2008 et le 30 mars 2014
#     Elu conseiller métropolitain le 15 décembre 2015
#     Elu adjoint à la Maire, le 6 octobre 2017, chargé de toutes les questions relatives aux Sociétés d'économie mixte et aux sociétés publiques locales
#     Président du groupe Radical de Gauche, Centre et Indépendants
#     Elu adjoint au Maire, le 21 mars 2008, chargé du tourisme et des nouveaux médias locaux (Mandature 2008-2014)
#     Elu adjoint au Maire, le 18 mars 2001, chargé du tourisme (mandature 2001-2008)
#     Fonctions électives dans son arrondissement :
#     Représentations :
#     Président du Conseil d'Administration de la Société anonyme d’économie mixte de la gare routière de Rungis (SOGARIS)
#     Autres mandats :
#     Président de la fédération de Paris du parti radical
#     Trésorier du parti radical"
#     }
# ]

# deputies.each do |deputy|
#   new_deputy = Deputy.new(deputy)
#   p new_deputy
#   new_deputy.photo =  Rails.root.join("db/images/#{new_deputy.last_name}.jpeg").open
#   new_deputy.save
# end

# puts "creating city..."

# new_city = City.new(
#   zip_code: "27130",
#   departement: "l'Eure",
#   region: "Normandie",
#   intercommunalite: "Communauté de communes Normandie Sud Eure",
#   population: "320",
#   density: "25",
#   debt: nil,
#   current_maire: "Philippe Obadia",
#   name: "Les Barils"
# )
# new_city.user = User.find_by(first_name: "Charles")
# new_city.save

# puts "creating city's photos..."


# for i in 1..4
# picture = Photo.new(city_id: new_city[:id])
# picture.photo = Rails.root.join("db/images/mairie_#{i}.jpg").open
# picture.save
# # p picture
# end

puts "creating status.."

Status.create(status: "in_progress")
Status.create(status: "done")

puts "creating questionnaires..."

category = Category.find_by(name: "Sécurité")
questionnaire = Questionnaire.create(title: "Le constat sur la ville", category: category, order: 1, activated: true)
questionnaire_2 = Questionnaire.create(title: "Bilan de l’action municipale passée", category: category, order: 2, activated: true)
questionnaire_3 = Questionnaire.create(title: "Analyse de la délinquance", category: category, order: 3, activated: true)

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
  {question:"La sécurité est-elle une préoccupation autour des établissements scolaires ?",
   questionnaire: questionnaire_2
  },
  {question:"La sécurité est-elle une préoccupation dans les transports ?",
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


puts "update questionnaires with root question"

questionnaire.root_question_id = Question.find_by(question: "Diriez-vous que votre commune connait des problèmes d’insécurité ?").id
p questionnaire
questionnaire.save


questionnaire_2.root_question_id = Question.find_by(question: "Les municipalités précédentes ont-elles agit pour éradiquer la délinquance ?").id
p questionnaire_2
questionnaire_2.save


questionnaire_3.root_question_id = Question.find_by(question: "Diriez-vous que votre commune connait des problèmes d’insécurité ?").id
p questionnaire_3
questionnaire_3.save



puts "creating answers for questionnaire 1..."

aq_0 = Answer.create(question_id: question_ids[0], answer: "Oui", next_question_id: Question.find_by(question:"Disposez-vous de chiffres concernant la délinquance dans votre commune ?").id)
aq_1 = Answer.create(question_id: question_ids[0], answer: "Non")
aq_2 = Answer.create(question_id: question_ids[1], answer: "Oui", next_question_id: Question.find_by(question: "La délinquance est-elle plus forte que dans les autres communes ?").id)
aq_3 = Answer.create(question_id: question_ids[2], answer: "Oui")

aq_4 = Answer.create(question_id: question_ids[2], answer: "Non")
aq_5 = Answer.create(question_id: question_ids[1], answer: "Non")


qq_1 = [aq_0.id, aq_1.id, aq_2.id, aq_3.id]

puts "creating answers for questionnaire 2..."

aq_2_0 = Answer.create(question_id: question_2_ids[0], answer: "Oui", next_question_id: Question.find_by(question:"La sécurité est-elle une préoccupation autour des établissements scolaires ?").id)
aq_2_1 = Answer.create(question_id: question_2_ids[0], answer: "Non", next_question_id: Question.find_by(question:"La sécurité est-elle une préoccupation autour des établissements scolaires ?").id)
aq_2_2 = Answer.create(question_id: question_2_ids[1], answer: "Oui", next_question_id: Question.find_by(question:"La sécurité est-elle une préoccupation dans les transports ?").id)
aq_2_3 = Answer.create(question_id: question_2_ids[2], answer: "Oui")


aq_2_4 = Answer.create(question_id: question_2_ids[1], answer: "Non", next_question_id: Question.find_by(question:"La sécurité est-elle une préoccupation dans les transports ?").id)
aq_2_5 = Answer.create(question_id: question_2_ids[2], answer: "Non")

qq_2 = [aq_2_0.id, aq_2_1.id, aq_2_2.id, aq_2_3.id]


puts "creating answers for questionnaire 3..."

aq_3_0 = Answer.create(question_id: question_3_ids[0], answer: "Déliquance issue de la ville")
aq_3_1 = Answer.create(question_id: question_3_ids[0], answer: "Délinquance de transit")
aq_3_2 = Answer.create(question_id: question_3_ids[0], answer: "Les deux")


qq_3 = [aq_3_0.id, aq_3_1.id, aq_3_2.id ]

puts "creating programs..."
file = "db/programs.yml"
programs = YAML.load(open(file).read)

program_ids = []
# n = 0
programs["programs"].each_with_index do |program, index|
  # Category.create!(categories[n])
  u = Program.new(program)
  u.category = Category.find_by(name: "Sécurité")
  u.answer = Answer.find(qq_1[index])
  p u
  u.save
  p u
  # n += 1
  end


file = "db/programs_2.yml"
programs_2 = YAML.load(open(file).read)

program_2_ids = []
# n = 0
programs_2["programs"].each_with_index do |program, index|
  # Category.create!(categories[n])
  u = Program.new(program)
  u.category = Category.find_by(name: "Sécurité")
  u.answer = Answer.find(qq_2[index])
  p u
  u.save
  p u
  # n += 1
end


file = "db/programs_3.yml"
programs_3 = YAML.load(open(file).read)

program_3_ids = []
# n = 0
programs_3["programs"].each_with_index do |program, index|
  # Category.create!(categories[n])
  u = Program.new(program)
  u.category = Category.find_by(name: "Sécurité")
  u.answer = Answer.find(qq_3[index])
  p u
  u.save
  p u
  # n += 1
end

puts "seeds done"
