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

  (1..50).each do |i|
    screen.clear

    x, y = [Math.sin(i), Math.cos(i)]
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    i += 10
    x, y = [Math.sin(i), Math.cos(i)]
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    i += 10
    x, y = [Math.sin(i), Math.cos(i)]
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    i += 10
    x, y = [Math.sin(i), Math.cos(i)]
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)
    
    i += 10
    x, y = [Math.sin(i), Math.cos(i)]
    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    screen.flush
    sleep 0.08
  end

  screen.show_cursor

end

main()

