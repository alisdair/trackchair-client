require 'active_support'
require 'active_model'

class Model
  include ActiveModel::Model

  cattr_accessor :store

  def store
    self.class.store
  end
end
