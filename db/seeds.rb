# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Make.create(name: 'HP')
Make.create(name: 'Lenovo')
Make.create(name: 'Ciara')

Model.create(name: '6570b', series: 'i-series', make_id: 1)
Model.create(name: '8005', series: 'Dual-core', make_id: 1)