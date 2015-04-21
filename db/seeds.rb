# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: "admin@admin.com", password: "adminadmin", password_confirmation: "adminadmin", role: 'admin')

['Test', 'HTML', 'Code'].each do |c|
  Category.create(name: c)
end

User.create(email: "tutor@tutor.com", password: "tutortutor", password_confirmation: "tutortutor", role: 'tutor')
User.create(email: "student@student.com", password: "studentstudent", password_confirmation: "studentstudent", role: 'student')
