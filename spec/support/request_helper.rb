module Requests
  module JsonHelpers
    def expect_status(expectation)
      expect(response.status).to eql(expectation)
    end

    def json
      JSON.parse(response.body)
    end
  end

  module SerializerHelpers
    def serialized serializer, object
      JSON.parse(serializer.new(object).to_json)
    end

    def each_serialized serializer, object
      serialized = ActiveModelSerializers::SerializableResource.new(object, each_serializer: serializer).to_json
      JSON.parse(serialized)
    end
  end
end
