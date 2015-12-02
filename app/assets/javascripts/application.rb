require 'opal'
require 'clearwater'

require 'db_monster'

app = Clearwater::Application.new(
  component: DBMonster.new,
  element: $document['#app'],
)
app.call

rerender = proc do
  app.render
  animation_frame { rerender.call }
end

rerender.call
