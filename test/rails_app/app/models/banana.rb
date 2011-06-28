class Banana < ActiveRecord::Base
  belongs_to :apple
  belongs_to :dragonfruit

  has_many :coconuts

  resourceful_model do
    fields :name, :number, :coconuts, :apple, :dragonfruit
    collections :find_some, :all
  end

  scope :find_some, where("number < 100")
end
