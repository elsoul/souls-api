require "./app"
require "graphql_playground"

map "/playground" do
  use GraphQLPlayground, endpoint: "/graphql" # endpoint to your graphql server endpoint
end

run SoulsApi
