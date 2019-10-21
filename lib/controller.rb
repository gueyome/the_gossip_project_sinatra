require 'bundler'
Bundler.require

require 'gossip'
require 'pry'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  
  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    #puts "Salut, je suis dans le serveur"
    #puts "Ceci est le contenu du hash params : #{params}"
    #puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["gossip_author"]}"
    #puts "De la bombe, et du coup ça, ça doit être ce que l'utilisateur a passé dans le champ gossip_content : #{params["gossip_content"]}"
    #puts "Ça déchire sa mémé, bon allez je m'en vais du serveur, ciao les BGs !"
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect'/'
  end

  get '/gossips/:id' do
    erb :show, locals: {gossip_author: Gossip.find(params['id'].to_i).author, gossip_content: Gossip.find(params['id'].to_i).content, gossip_id: params['id']}
    #puts "Voici le numéro du potin que tu veux : #{params['id']} !"
    #puts "Voici l'autheur du potin que tu veux : #{Gossip.find(params['id'].to_i).author} !"
    #puts "Voici le contenu du potin que tu veux : #{Gossip.find(params['id'].to_i).content} !"
  end

  get '/gossips/:id/edit' do
    erb :edit, locals: {gossip_id: params['id']}
  end
  
  post '/gossips/:id/edit/' do
    gossip_new = Gossip.find(params["id"].to_i)
    #binding.pry
    gossip_new.author = params["gossip_author_new"]
    gossip_new.content = params["gossip_content_new"]
    Gossip.update(params["id"].to_i, gossip_new)
    redirect'/'
  end

end