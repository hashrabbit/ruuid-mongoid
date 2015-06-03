require 'mongoid'
require 'ruuid'

require 'ruuid/mongoid/version'
require 'ruuid/mongoid/extensions/uuid'

Mongoid::Fields::TYPE_MAPPINGS[:uuid] = RUUID::UUID

module RUUID
  module Mongoid
    extend ActiveSupport::Concern

    included do
      field(
        :_id,
        default: ->{ RUUID::UUID.new },
        pre_processed: true,
        type: RUUID::UUID
      )

      alias :id :_id
      alias :id= :_id=
    end
  end
end
