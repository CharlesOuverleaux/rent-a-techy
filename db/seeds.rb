require 'faker'

TECHY = "techy"
USER = "user"
PW = "123456"

def c_techy(first, last)
  un = "#{first}#{last}" # username
  un = un.delete(' ')
  user = User.create(first_name: first,
                     last_name: last,
                     user_name: un,
                     img_path: "profiles/#{un}.png",
                     email: Faker::Internet.email,
                     role: TECHY,
                     password: PW)
  puts "Techy: #{un}"

  # create offers for techy
  rand(1..3).times do
    offer = Offer.create(title: Faker::Computer.platform,
                         description: Faker::Quote.famous_last_words,
                         user: user)
    puts "\t-> added offer"
  end
end

c_techy('Charles', 'Overlaux')
c_techy('Arif', 'Gömleksiz')
c_techy('Maxim', 'Wolotschij')
c_techy('Hannes', 'Schaletzky')

# done
puts "\nSeeding done."
puts "L0ve from Hänn3s"
