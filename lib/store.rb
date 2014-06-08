class Store
  def initialize
    @store = {}
  end

  def <<(object)
    type = object.class
    @store[type] ||= {}
    @store[type][object.id] = object
  end

  def find(type, id)
    @store[type][id]
  end

  def all(type)
    @store[type].values
  end
end
