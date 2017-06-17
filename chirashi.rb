require 'optparse'
require './screen'

def main
  opt = OptionParser.new

  character = "🍣"
  opt.on('-c [VAL]') do |value|
    if File.exist?(value)
      data = `base64 < #{value}`
      character = "\033]1337;File=inline=1:#{data}\a"
    else
      character = value
    end
  end

  opt.parse!(ARGV)

  screen = Screen.new
  screen.hide_cursor

  (1..100).each do |i|
    screen.clear

    x=i/(200/3.0)
    y=x*2
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    x=-i/(200/3.0)
    y=x*2
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    x=i/(200/3.0)
    y=-x*2
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    x=-i/(200/3.0)
    y=-x*2
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    x=i/(200/3.0)
    y=0
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    x=-i/(200/3.0)
    y=0
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    screen.flush
    sleep 0.01
  end

  screen.show_cursor

end

main()

