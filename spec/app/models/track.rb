class Track
  include Mongoid::Document

  embedded_in :album
end
