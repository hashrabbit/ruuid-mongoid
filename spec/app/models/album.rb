class Album
  include Mongoid::Document
  include RUUID::Mongoid

  belongs_to :artist

  embeds_many :tracks
end
