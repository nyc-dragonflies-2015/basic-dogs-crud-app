# "Index"
get '/dogs' do
  @dogs = Dog.all
  @count = Dog.count
  erb :'dogs/index'
end
