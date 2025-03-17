class BaseSerializer
  def initialize(object)
    @object = object
  end

  def as_json
    raise NotImplementedError, "Subclasses must implement as_json"
  end

  def self.serialize_collection(collection)
    collection.map { |item| new(item).as_json }
  end
end
