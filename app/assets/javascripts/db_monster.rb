require 'clearwater/component'

class DBMonster
  include Clearwater::Component

  attr_reader :rows

  def initialize rows=20
    @rows = rows
  end

  def render
    table({ class: 'table table-striped latest-data' }, [
      tbody([
        Array.new(rows) { |row|
          [
            Database.new("cluster#{row}"),
            Database.new("cluster#{row}slave"),
          ]
        },
      ]),
    ])
  end
end

class Database
  include Clearwater::Component

  attr_reader :name

  def initialize name
    @name = name
  end

  def render
    tr([
      td({ class: 'dbname' }, name),
      td({ class: 'query-count' }, query_count),
      Array.new(5) { Query.new }
    ])
  end

  def query_count range=0..10
    count = rand(range)
    class_name = count < 10 ? 'label-success' : 'label-warning'
    span({ class: "label #{class_name}" }, count)
  end
end

class Query
  include Clearwater::Component

  attr_reader :elapsed_time

  def initialize
    @elapsed_time = rand > 0.1 ? rand * 15 : nil
  end

  def render
    td({ class: "Query elapsed #{class_name}" }, [
      elapsed_time && elapsed_time.round(2),
      div({ class: 'popover left' }, [
        div({ class: 'popover-content' }, query),
        div({ class: 'arrow' }),
      ]),
    ])
  end

  def query
    if elapsed_time
      'SELECT * FROM blah'
    else
      '<IDLE>'
    end
  end

  def class_name
    if elapsed_time.nil?
      :warn
    elsif elapsed_time < 1
      :warn_short
    elsif elapsed_time > 10
      :warn_long
    else
      :warn
    end
  end
end
