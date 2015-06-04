module RUUID
  module Mongoid
    module Extensions
      module UUID
        # Turn the object from the Ruby type we deal with to a
        # Mongo-friendly type.
        #
        # @return [BSON::Binary]
        #   The mongoized object.
        def mongoize
          BSON::Binary.new(data, :uuid)
        end

        delegate :bson_type, :to_bson, to: :mongoize

        module ClassMethods
          # Convert the object from its Mongo-friendly Ruby type to this type.
          #
          # @param [BSON::Binary] object
          #   The object to demongoize.
          #
          # @return [RUUID::UUID]
          #   The demongoized UUID.
          def demongoize(object)
            case object
            when BSON::Binary
              new(object.data)
            when ::String
              parse(object)
            else
              object
            end
          end

          # Turn the object from the Ruby type we deal with to a
          # Mongo-friendly type.
          #
          # @param [RUUID::UUID] object
          #   The object to mongoize.
          #
          # @return [BSON::Binary]
          #   The mongoized object.
          def mongoize(object)
            return object if object.nil?
            parse(object).mongoize rescue object.mongoize
          end
          alias_method :evolve, :mongoize
        end
      end
    end
  end
end

::RUUID::UUID.__send__(:include, RUUID::Mongoid::Extensions::UUID)
::RUUID::UUID.extend(RUUID::Mongoid::Extensions::UUID::ClassMethods)
