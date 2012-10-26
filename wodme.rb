require 'sinatra'

@WODS
@MOBS

before do
  loadwods
end

get '/mob' do
  n_of_list(3,@MOBS).join("<br />") 
end

get '/wod' do
  @WODS[rand(@WODS.size)].gsub(/\n/,"<br />")
end


def n_of_list(n,list)
  n.times.map{|n| list[rand(list.size)]}
end

def loadwods
  return if @WODS
  wods = ''
  mobs = ''
  File.open('wods.txt','r').each do |line|
    if mobs.empty? && line !~ /#MOB/
      wods << line 
    else 
      mobs << line
    end
  end 
  @WODS = wods.split(/\s*#WOD\s*/).reject{|line| line == "" }
  @MOBS = mobs.split(/\s*#MOB\s*/).reject{|line| line == "" }
end 


