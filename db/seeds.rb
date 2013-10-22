# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

skills = [
  "Java", 
  "Ruby", 
  "C++",
  "Lysp",
  "UI Design",
  "UX",
  "Perl",
  "HTML5",
  "Erlang",
  "Javascript",
  "jQuery",
  "Smalltalk",
  "DevOps",
  "Chef",
  "Angular",
  "Node.js",
  "Backbone.js",
  "TDD",
  "Ember",
  "PostgreSQL",
  "MySQL"
]

#Populate Skills Table
skills.each do |skill|
  Skill.create(name: skill) if Skill.where(name: skill).empty?
end