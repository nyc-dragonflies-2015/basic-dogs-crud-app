require_relative '../spec_helper'

describe 'Canary Test' do 
  #Canary Test... If this fails, you have bigger issues
  it 'should be a canary in a coal mine' do
    expect(true).to be(true)
  end
end 

describe 'Users Controller' do
  
  let(:current_user) { User.create(first_name: 'Bobby', last_name: 'Drake', email:'iceman@xmen.com', age:25 ) }
  let(:user_params)  { {user: {first_name: 'Jean', last_name: 'Grey', email:'thepoenix@xmen.com', age: 29}} }


  context 'user#index' do

    before do
      current_user
      get '/users'
    end

    it 'should get users#index' do
      expect(last_response).to be_ok
    end

    it 'should display the user on the page' do
      expect(last_response.body).to include("Bobby")
    end
   
  end

  context 'user#show' do

    before do
      get "/users/#{current_user.id}"
    end

    it 'should get users#show' do
      expect(last_response).to be_ok
    end

    it "should display the users first name" do
      expect(last_response.body).to include("Bobby")
    end

    it "should display the users last name" do
      expect(last_response.body).to include("Drake")
    end

    it "should display the users email" do
      expect(last_response.body).to include("iceman@xmen.com")
    end

    it "should display the users user" do
      expect(last_response.body).to include("25")
    end
   
    it 'should get 500 if no user exists' do 
      get "/users/0"
      expect(last_response.status).to be(500)
      expect(last_response.body).to include("No User Found")
    end

  end

  context 'user#new' do
    before do
      get "/users/new"
    end
    it 'should get users#new' do
      expect(last_response).to be_ok
    end
    
    it 'should have add user button' do
      expect(last_response.body).to include("Add User")
    end
  end

  context 'user#create' do
    before do 
      post '/users', params=user_params
    end

    it 'should create a new user' do 
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to include ("Jean")
    end
  end

  context 'user#edit' do
    before do 
      get "users/#{current_user.id}/edit"
    end

    it 'should get users#edit' do
      expect(last_response).to be_ok
    end
    
    it "should display the users first name" do
      expect(last_response.body).to include("Bobby")
    end

    it "should display the users last name" do
      expect(last_response.body).to include("Drake")
    end

    it "should display the users email" do
      expect(last_response.body).to include("iceman@xmen.com")
    end

    it "should display the users user" do
      expect(last_response.body).to include("25")
    end
   
    it 'should get 500 if no user exists' do 
      get "/users/0/edit"
      expect(last_response.status).to be(500)
      expect(last_response.body).to include("No User Found")
    end
  end 

  context 'user#update' do
    before do
      put "/users/#{current_user.id}", params=user_params 
    end

    it 'should put users#update' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to include (user_params[:user][:first_name])
    end
  end

  context 'user#delete' do
    before do 
      delete "/users/#{current_user.id}"
    end

    it 'should delete users#delete' do
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response.body).to_not include (current_user.first_name)
    end

    it 'should remove user from the database' do
      expect(User.all.length).to be(0)
    end
  end
end
