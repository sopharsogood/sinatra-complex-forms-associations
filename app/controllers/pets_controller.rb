class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet_attributes = Hash.new
    @pet_attributes[:name] = params[:pet_name]
    @pet_attributes[:owner_id] = params[:owner_id]
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet_attributes[:owner_id] = @owner.id
    end
    @pet = Pet.create(@pet_attributes)
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end


  patch '/pets/:id' do 
    @pet_attributes = Hash.new
    @pet_attributes[:name] = params[:pet_name]
    @pet_attributes[:owner_id] = params[:owner_id]
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
      @pet_attributes[:owner_id] = @owner.id
    end
    @pet = Pet.update(@pet_attributes)
    redirect to "pets/#{@pet.id}"
  end
end