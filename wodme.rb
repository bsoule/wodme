require 'sinatra'
require 'haml'
require 'active_support/time'

before do
  @now = Time.now.in_time_zone(ActiveSupport::TimeZone["America/Los_Angeles"])
  hat = Random.new(@now.to_i/(60*60*24))
  wods,mobs = loadwods
  @WOD = wods[hat.rand(wods.size)].split /\n/
  @MOB = n_of_list(3,mobs,hat)
end

get %r{/(mob|wod)?} do
  haml :index
end

def n_of_list(n,list,hat=Random)
  ret = []
  list.each_index do |i|
    ret << list[i] if hat.rand < (n-ret.size)/(list.size-i.to_f) 
  end 
  ret
end

def loadwods
  wods = ''
  mobs = ''
  File.open('wods.txt','r').each do |line|
    if mobs.empty? && line !~ /#MOB/
      wods << line 
    else 
      mobs << line
    end
  end 
  [wods.split(/\s*#WOD\s*/).reject{|line| line == "" },
   mobs.split(/\s*#MOB\s*/).reject{|line| line == "" }]
end 


