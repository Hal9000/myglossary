# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(email: ENV.fetch("ADMIN_EMAIL")) do |user|
  puts "Seeding Admin User"
  user.password = ENV.fetch("ADMIN_PASSWORD")
  user.first_name = ENV.fetch("ADMIN_FIRST_NAME")
  user.last_name = ENV.fetch("ADMIN_LAST_NAME")
end

words = %w(apollo able baker delta epsilon)

words.each do |word|
  Word.find_or_create_by(word: word) do |word|
    puts "Seeding Word: #{word.word}"
    word.status = "unclaimed"
  end
end
