require 'rest-client'
require 'json'
require 'active_support/inflector'
require 'uri'

require_relative 'model'
require_relative 'store'
require_relative 'token'
require_relative 'models/account'
require_relative 'models/paper'
require_relative 'models/track'

class Client
  BASE_URI = 'https://%s.trackchair.com/api'
  attr_accessor :api, :store

  def initialize(host_name:'www', token:nil)
    uri = BASE_URI % host_name

    options = { }
    unless token.nil?
      options[:headers] = {
        Authorization: "Bearer #{token}"
      }
    end

    @api = RestClient::Resource.new(uri, options)
    @store = Store.new
  end

  def fetch(resource, *classes)
    response = JSON.parse(api[resource].get({ accept: 'application/json' }))

    classes.each do |c|
      single = c.name.underscore
      plural = single.pluralize

      if response[single]
        store << c.new(response[single])
      end

      if response[plural]
        response[plural].each {|x| store << c.new(x) }
      end
    end
  end

  def update(resource, id, params)
    plural = resource.pluralize
    payload = { resource => params }
    api["#{plural}/#{id}"].put(payload, { accept: 'application/json'})
  end

  def search(resource, query, *classes)
    query = URI.encode_www_form(query)
    fetch("#{resource}?#{query}", *classes)
  end

  def login(email, password)
    response = api['tokens'].post(email: email, password: password)
    JSON.parse(response)['access_token']
  end
end
