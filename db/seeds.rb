require 'faker'

# changed ö -> oe for Arif, Gyoergyi, Christian

TECHY = "techy"
USER = "user"
PW = "123456"
STATUS = ["pending", "confirmed", "declined"]
TITLES = [
  "Helping with <q>",
  "<q> Support <3",
  "Your friendly <q> hero",
  "<q> super service!",
  "<q> machine!",
  "<q> assistant :)",
  "Fixing <q> issues",
  "Simple <q>!",
  "Enhancing <q>",
  "<q> difficulties?",
  "<q> help?"
]

# create random titel
def c_title(skill)
  return TITLES.sample.gsub("<q>", skill.name)
end

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

  # add one offer per techy
  unless isCustomer
    # generate 1 to 5 skills -> connected numbers
    skill_id = rand(0...Skill.count - 4)
    skills = Skill.all[skill_id..(skill_id + rand(0..4))]
    # randomize available_now -> only 1/3 are true
    now = (rand(1..3) % 2).zero?
    # generate rate
    rate = rand(25..150)
    # create offer
    offer = Offer.create(title: c_title(skills.sample),
                         description: Faker::Hacker.say_something_smart,
                         user: user,
                         skills: skills,
                         available_now: now,
                         hourly_rate: rate)
    puts "-> added offer"
    skills.each { |skill| puts "    #{skill.name}" }
  end
end

@hc = 0 # hue_code
def c_skill(name)
  return if @hc > 359
  Skill.create(name: name, hue_code: @hc)
  puts "added: #{@hc} - #{name}"
  @hc += 10
end

#remove all
puts "removing old data..."
Booking.destroy_all
Offer.destroy_all
User.destroy_all
Skill.destroy_all

puts "\nstarting to seed..."

# ------ SKILLS ------
# Ruby
c_skill('Ruby')
c_skill('Rails')
c_skill('ActiveRecord')
c_skill('SublimeText')
c_skill('RSpec')
# JS/TS
c_skill('Javascript')
c_skill('Typescript')
c_skill('React')
c_skill('Vue')
c_skill('Bootstrap')
c_skill('Tailwind')
c_skill('Svelte')
c_skill('VSCode')
# WebDev
c_skill('HTML')
c_skill('CSS')
c_skill('SASS')
c_skill('LESS')
# .NET
c_skill('C#')
c_skill('.NET')
c_skill('VB')
c_skill('VBA')
c_skill('VisualStudio')
# Python
c_skill('Python')
c_skill('Django')
c_skill('Flask')
# Java
c_skill('Java')
c_skill('Spring')
c_skill('IntelliJ')
# DevOps
c_skill('git')
c_skill('GitHub')
c_skill('Azure')
c_skill('Heroku')
c_skill('AWS')
c_skill('CD')
c_skill('CI')
c_skill('Testing')

# techies team
c_users('Charles', 'Ouverleaux')
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
