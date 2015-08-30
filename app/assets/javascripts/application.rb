require 'opal'
require 'clearwater'

class Layout
  include Clearwater::Component

  def render
    div 'Hello, Clearwater!'
  end
end

app = Clearwater::Application.new(component: Layout.new)
app.call
