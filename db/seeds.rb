require 'faker'

# changed ö -> oe for Arif, Gyoergyi, Christian

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
    1.times do
      offer = Offer.create(title: Faker::Computer.platform,
                           description: Faker::Quote.famous_last_words,
                           user: user)
      puts "\t-> added offer"
    end
  end
end

#remove all
puts "removing old data..."
Booking.destroy_all
Offer.destroy_all
User.destroy_all

puts "\nstarting to seed..."
# techies team
c_users('Charles', 'Overlaux')
c_users('Arif', 'Goemleksiz')
c_users('Maxim', 'Wolotschij')
c_users('Hannes', 'Schaletzky')
# techies others
c_users('Nora', 'Von Breitenbach')
c_users('Erik', 'Vogler')
c_users('Maria', 'Vlad')
c_users('Valentina', 'Sapigni')
c_users('Conor', 'Quarry')
c_users('Prabha', 'Pothen')
c_users('Dusan', 'Pejcic')
c_users('Christina', 'Oechsle')
c_users('Vojtech', 'Matous')
c_users('Mohamed', 'Mara')
c_users('Lisa-Marie', 'Maaß')
c_users('Jishuo', 'Ma')
c_users('Bruno', 'Kreidler')
c_users('Lisa', 'Keßler')
c_users('Oguz', 'Karahanoglu')
c_users('Emily', 'Hoult')
c_users('Vedran', 'Hamovic')
c_users('Vincenzo', 'Galante')
c_users('Gyoergyi', 'Farkas')
c_users('Hannah', 'Eichelsdoerfer')
c_users('Emanuele', 'Del Prete')
c_users('Christian', 'Boehme')
c_users('Neytullah', 'Bahadir')
c_users('Mais', 'Aroq')
c_users('Jeanie', 'Ahn')

# customers
puts "\n"
10.times do
  names = Faker::FunnyName.name.split(' ')
  c_users(names.first, names.last, true)
end

# bookings
puts "\n"
customers = User.where(role: USER)
20.times do
  booking = Booking.create(user: customers.sample,
                           offer: Offer.all.sample,
                           booking_date:"#{rand(1..28)}/#{rand(3..10)}/20#{rand(14..21)}",
                           status: STATUS.sample)
  puts "#{booking.status} - #{booking.user.user_name} booked #{booking.offer.user.user_name} for #{booking.booking_date}"
end

# done

puts "\n--------------------------\nSeeding done."
puts "L0ve from Hänn3s"
