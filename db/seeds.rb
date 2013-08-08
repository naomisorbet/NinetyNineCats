# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cats = Cat.create([
  { name: 'Gato', age: 55, birth_date: Date.new(2005, 6, 17), color: 'black', sex: 'ambiguous' },
  { name: 'Chocolate', age: 3, birth_date: Date.new(2001,10,30), color: 'orangeish', sex: 'ambiguous' },
  { name: 'Crispy', age: 22, birth_date: Date.new(2010, 4, 5), color: 'brown', sex: 'ambiguous' }
  ])

rentals = CatRentalRequest.create([
  {cat_id: 1, begin_date: Date.new(2013, 10, 1), end_date: Date.new(2013, 10, 5)},
  {cat_id: 1, begin_date: Date.new(2013, 8, 9), end_date: Date.new(2013, 8, 10)}
])