# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = [
  [1,'Lost'],
  [2,'Found'],
  [3,'Free Stuff'],
  [4,'Jobs'],
  [5,'Wanted']
]

categories.each do |id, name|
  Category.create( id: id, name: name )
  Post.create( category_id: id, title: "#{name} Test Post #{id}", author: 'testuser', email: 'test@gpmail.org', description: 'This is a sample post' )
end
