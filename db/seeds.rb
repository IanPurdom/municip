# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "cleaning seeds..."
Deputy.destroy_all
User.destroy_all

puts "creating seeds..."

yann = User.create(first_name: "yan", last_name: "de Catheu", email: "yann@mail.com", password: '123456')

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

deputies.each_with_index do |deputy, index|
  new_deputy = Deputy.new(deputy)
  new_deputy.save
end

puts "seeds done"
