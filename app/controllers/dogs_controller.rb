# "Index"
get '/dogs' do
  @dogs = Dog.all
  @count = Dog.count
  erb :'dogs/index'
end

# "New"
get '/dogs/new' do
  erb :'dogs/new'
end

# "Show"
get '/dogs/:name' do
  @dog = Dog.find_by(name: params[:name])
  erb :'dogs/show'
end

# "Create the new instance"
post '/dogs' do
  Dog.create(params[:dog])
  redirect '/dogs'
end

# Display a form that we can use to alter an existing record
get '/dogs/:id/edit' do
end

patch '/dogs/:id' do
end

delete '/dogs/:id' do
  Dog.find(params[:id]).destroy
  redirect '/dogs'
end
