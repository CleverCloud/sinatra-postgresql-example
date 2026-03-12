# frozen_string_literal: true

require 'json'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'
require 'securerandom'

require_relative '../models/user'

class DemoApi < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/:name' do
    user = User.find_by(name: params[:name])
    halt 404 if user.nil?
    json user
  end

  post '/' do
    request.body.rewind
    name = request.body.read.strip
    halt 400 if name.empty?
    user = User.create(user_id: SecureRandom.uuid, name: name)
    halt 400 unless user.valid?
    json user
  end
end
