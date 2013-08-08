# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cats = Cat.create([
  { name: 'Gato', age: 55, birth_date: 4/4/1999, color: 'black', sex: 'ambiguous' },
  { name: 'Chocolate', age: 3, birth_date: 3/8/1980, color: 'orangeish', sex: 'ambiguous' },
  { name: 'Crispy', age: 22, birth_date: 9/2/2002, color: 'brown', sex: 'ambiguous' }
  ])