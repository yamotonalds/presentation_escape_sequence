require './screen'

def main
  filename = 'serval_jump.png'
  data = `base64 < #{filename}`
  character = "\033]1337;File=inline=1:#{data}\a"

  screen = Screen.new
  screen.hide_cursor

  (1..20).each do |i|
    screen.clear

    x=(100-i * 6)/(100/2/3.0)-100/(100/3.0)
    y=x

    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    screen.flush
    sleep 0.1
  end

  screen.show_cursor

end

main()

