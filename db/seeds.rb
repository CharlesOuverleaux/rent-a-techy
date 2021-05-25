require 'faker'

TECHY = "techy"
USER = "user"
PW = "123456"

def c_user(first, last)
  un = "#{first}#{last}" # username
  un = un.delete(' ')
  User.create(first_name: first,
              last_name: last,
              user_name: un,
              img_path: "profiles/#{un}.png",
              email: Faker::Internet.email,
              role: TECHY,
              password: PW)
  puts "created: #{un}"
end

c_user('Charles', 'Overlaux')
c_user('Arif', 'Gömleksiz')
c_user('Maxim', 'Wolotschij')
c_user('Hannes', 'Schaletzky')

# done
puts "\nSeeding done."
puts "L0ve from Hänn3s"
