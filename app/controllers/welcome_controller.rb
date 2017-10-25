require 'yaml'
class WelcomeController < ApplicationController
  
  def initial
    roles = [] 
	roles += ['狼人'] * params[:wolf].to_i
	roles += ['贫民'] * params[:civil].to_i
	roles += ['预言家'] * params[:seer].to_i
	roles += ['盗贼'] * params[:robber].to_i
	roles += ['捣蛋鬼'] * params[:trouble].to_i
  	@players = {}
  	roles.shuffle!
  	(1..roles.size).to_a.map do | num | 
  	  if num <= roles.size - params[:extra].to_i
  	  	@players[num.to_s] = roles[num-1]
  	  else
  	  	@players['空置' + num.to_s] = roles[num-1]
  	  end
  	end
  	File.new('db/game.yml')
  	File.open('db/game.yml','w') do |file|
  		file.write @players.to_yaml
  	end
  	redirect_to :action => 'index'
  end
  
  def enter
  	redirect_to :action => "index"
  end
    
  def index
  	@players =  YAML.load_file(File.join(::Rails.root, 'db', 'game.yml'))
  end
  
  def show
    #@players = session[:players]
  	@players =  YAML.load_file(File.join(::Rails.root, 'db', 'game.yml'))
  end
  
  def swap
  	@players = YAML.load_file(File.join(::Rails.root, 'db', 'game.yml'))
  	middle = @players[params[:her].to_s]
  	@players[params[:her].to_s] = @players[params[:he].to_s]
  	@players[params[:he].to_s] = middle
  	#session[:players] = @players
  	File.new('db/game.yml')
  	File.open('db/game.yml','w') do |file|
  		file.write @players.to_yaml
  	end
  	redirect_to :action => 'index'
  end
  
  def steal
  	@players = YAML.load_file(File.join(::Rails.root, 'db', 'game.yml'))
  	@players[@players.index('盗贼')] = @players[params[:he].to_s]
  	@players[params[:he].to_s] = '盗贼'
  	#session[:players] = @players
  	File.new('db/game.yml')
  	File.open('db/game.yml','w') do |file|
  		file.write @players.to_yaml
  	end
  	redirect_to :action => 'index'
  end
  
end
