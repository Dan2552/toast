class Dragonfruit < ActiveRecord::Base

  has_one :banana

  has_many :coconut_dragonfruits
  has_many :coconuts, :through => :coconut_dragonfruits
  
end
