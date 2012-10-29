require 'sinatra'

@hat 
@WODS
@MOBS

before do
  loadwods
  @hat = Random.new(Time.now.to_i/(60*60*24))
end

get '/' do 
  
end

get '/mob' do
  n_of_list(3,@MOBS).join("<br />") 
end

get '/wod' do
  @WODS[@hat.rand(@WODS.size)].gsub(/\n/,"<br />")
end


def n_of_list(n,list)
  ret = []
  list.each_index do |i|
    ret << list[i] if @hat.rand < (n-ret.size)/(list.size-i.to_f) 
  end 
  ret
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


