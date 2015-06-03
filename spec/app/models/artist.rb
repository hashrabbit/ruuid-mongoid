class Artist
  include Mongoid::Document
  include RUUID::Mongoid

  field :name

  has_many :albums
end
