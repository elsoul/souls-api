require 'graphql'
require_relative 'query'
require_relative 'mutation'

class SoulsApiSchema < GraphQL::Schema
  query QueryType
  mutation MutationType
end
