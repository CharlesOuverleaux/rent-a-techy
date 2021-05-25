require 'faker'

TECHY = "techy"
USER = "user"
PW = "123456"
STATUS = ["pending", "confirmed", "declined"]

# method to create customers and techies
def c_users(first, last, isCustomer = false)
  un = "#{first}#{last}" # username
  un = un.delete(' ')
  user = User.create(first_name: first,
                     last_name: last,
                     user_name: un,
                     img_path: "profiles/#{un}.png",
                     email: Faker::Internet.email,
                     role: isCustomer ? USER : TECHY,
                     password: PW)
  puts "#{isCustomer ? 'Customer' : 'Techy'}: #{un}"

  # offers (only for techies)
  unless isCustomer
    rand(1..3).times do
      offer = Offer.create(title: Faker::Computer.platform,
                           description: Faker::Quote.famous_last_words,
                           user: user)
      puts "\t-> added offer"
    end
  end
end

# techies
c_users('Charles', 'Overlaux')
c_users('Arif', 'Gömleksiz')
c_users('Maxim', 'Wolotschij')
c_users('Hannes', 'Schaletzky')

# customers
puts "\n"
5.times do
  names = Faker::FunnyName.name.split(' ')
  c_users(names.first, names.last, true)
end

# bookings
customers = User.where(role: USER)
20.times do
  Booking.create(user: customers.sample,
                 offer: Offer.all.sample,
                 booking_date:"#{rand(1..28)}/#{rand(3..10)}/20#{rand(14..21)}",
                 status: STATUS.sample)
end
puts "\nCreated 20 bookings"

# done
puts "\nSeeding done."
puts "L0ve from Hänn3s"
