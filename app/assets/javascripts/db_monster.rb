require 'clearwater/component'
require 'database'

class DBMonster
  include Clearwater::Component

  attr_reader :rows

  def initialize rows=20
    @rows = rows
  end

  def render
    table({ class_name: 'table table-striped latest-data' }, [
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
