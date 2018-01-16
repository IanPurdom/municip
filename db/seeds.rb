# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "cleaning seeds..."

Program.destroy_all
Category.destroy_all
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
  zip_code: 27130,
  departement: "l'Eure",
  region: "Normandie",
  intercommunalite: "Communauté de communes Normandie Sud Eure",
  population: 320,
  density: 25,
  debt: nil,
  current_maire: "Philippe Obadia",
  name: "Les Barils"
)
new_city.user = User.find_by(first_name: "Charles")
new_city.photo_1 = Rails.root.join("db/images/mairie_1.jpg").open
new_city.photo_2 = Rails.root.join("db/images/mairie_2.jpg").open
new_city.photo_3 = Rails.root.join("db/images/mairie_3.jpg").open
new_city.save

puts "creating categories..."

categories = ["Finance", "Urbanisme", "Sécurité"]

categories.each do |category|
  Category.create!(name: category)
end

puts "creating programs & categories..."
file = "db/programs.yml"
programs = YAML.load(open(file).read)

n = 0
programs["programs"].each do |program|
  # Category.create!(categories[n])
  u = Program.new(program)
  u.category = Category.find_by(name: categories[n])
  u.save
  n += 1
end

puts "seeds done"
