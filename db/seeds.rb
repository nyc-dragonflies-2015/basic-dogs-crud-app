DOGS = [
  ["Byron", "Poodle"],
  ["Lassie", "Collie"],
  ["Margaret", "Schnoodle"]
]

DOGS.each do |dog|
  Dog.create(name: dog.first, breed: dog.last)
  puts "Created #{dog.first}"
end
