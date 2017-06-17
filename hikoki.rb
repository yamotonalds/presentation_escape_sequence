require 'optparse'
require './screen'

def main
  opt = OptionParser.new

  character = "✈"
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

  (-30..120).each do |i|
    screen.clear

    [0, 15, 20].each do |d|
      i += d

      # http://www004.upp.so-net.ne.jp/s_honma/curve/seiyo.htm
      s = i * 6 / 100.0 - 3
      x = (3 * (1 - s) * (1 - s**2)) / (1 + 3 * s**2)
      y = -(3 * (1 + s) * (1 - s**2)) / (1 + 3 * s**2)

      p = Point.new(x: x * 0.5, y: y * 0.5)

      screen.print(character: character, point: p)
    end

    screen.flush
    sleep 0.01
  end

  screen.show_cursor

end

main()

