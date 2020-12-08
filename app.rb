require "sinatra"
require "sinatra/json"
require "sinatra/activerecord"
require "rack/contrib"

require_relative "models/speaker"
require_relative "graphql/schema"

class SoulsApi < Sinatra::Base
  set :database_file, "config/database.yml"
  use Rack::JSONBodyParser

  get "/" do
    "It Works!"
  end

  get "/hello.json" do
    message = { success: true, message: "hello" }
    json message
  end

  get "/speakers" do
    @speakers = Speaker.all
    json @speakers
  end

  post "/graphql" do
    token = request.env["HTTP_AUTHORIZATION"]
    context = {
      token: token
    }
    result = SoulsApiSchema.execute(
      params[:query],
      variables: params[:variables],
      context: context
    )
    json result
  end
end
