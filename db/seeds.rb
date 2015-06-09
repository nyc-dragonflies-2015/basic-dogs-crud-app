zack = User.create(
  first_name: 'Zack',
  last_name: 'Mance',
  age: 29,
  email: 'zack@devbootcamp.com')
chris = User.create(
  first_name: 'Chris',
  last_name: 'DiMartino',
  age: 36,
  email: 'chrisd@devbootcamp.com',
  manager: zack)

garden = Garden.create(name: 'NY Botanical')

garden.users << zack << chris

flowers = %w{Tulip Pansy Hydrangea Banana Rose}.map { |name| Flower.create(name: name) }

flowers.each do |flower|
  Planting.create(flower: flower, garden: garden, quantity: rand(40..100))
end

insects = [Bee, Fly, Mantis].map do |name|
  insect = name.create
  garden.insects << insect
  insect
end

insects.each do |insect|
  insect.preferred_flowers << flowers.sample
end
