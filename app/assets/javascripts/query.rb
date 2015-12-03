require 'clearwater/component'

class Query
  include Clearwater::Component

  attr_reader :elapsed_time

  def initialize
    @elapsed_time = rand > 0.1 ? rand * 15 : nil
  end

  def render
    td({ class_name: "Query elapsed #{class_name}" }, [
      elapsed_time && elapsed_time.round(2),
      div({ class_name: 'popover left' }, [
        div({ class_name: 'popover-content' }, query),
        div({ class_name: 'arrow' }),
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
