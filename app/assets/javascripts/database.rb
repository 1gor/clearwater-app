require 'clearwater/component'
require 'query'

class Database
  include Clearwater::Component

  attr_reader :name

  def initialize name
    @name = name
  end

  def render
    tr([
      td({ class_name: 'dbname' }, name),
      td({ class_name: 'query-count' }, query_count),
      Array.new(5) { Query.new }
    ])
  end

  def query_count range=0..10
    count = rand(range)
    class_name = count < 10 ? 'label-success' : 'label-warning'
    span({ class_name: "label #{class_name}" }, count)
  end
end
