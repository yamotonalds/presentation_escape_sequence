
# ruby as.rb "[Math.sin(i), Math.cos(i)]"
# ruby as.rb "x=(100-i)/(100/2/3.0)-100/(100/3.0); y=x;[x,y]"

require 'optparse'

class Point
  attr_accessor :x, :y

  def initialize(x:, y:)
    self.x = x
    self.y = y
  end
end

class Screen
  def initialize
    @min_row = @min_col = 0
    @max_row, @max_col = `stty size`.scan(/\d+/).map(&:to_i)
    @row_offset = offset(@max_row)
    @col_offset = offset(@max_col)
  end

  def print(character:, point:)
    col, row = map(point)
    $stdout.print "\033[#{row};#{col}H#{character}\033[0;0H"
  end

  def clear
    puts "\033[2J"
  end

  def flush
    $stdout.flush
  end

  def hide_cursor
    puts "\033[?25l"
  end

  def show_cursor
    puts "\033[?25h"
  end

  private

  def offset(v)
    v / 2
  end

   def map(point)
    col = point.x.to_f
    row = point.y.to_f

    # スクリーン全体が縦横 -3〜3 くらいの描画範囲になるように調整
    col = col / 3 * @col_offset
    row = row / 3 * @row_offset
    
    # 原点をスクリーンの中心に変更
    col = col + @col_offset
    row = row + @row_offset

    [col.round, row.round]
  end
end

def main

  opt = OptionParser.new

  character = "\xf0\x9f\x8d\xa3"
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
  # p screen
  # exit

  # pic=serval()

  # print "\033]1337;File=inline=1:#{pic}\a"
  # $stdout.flush

  # c = "\033]1337;File=inline=1:#{serval}\a"
  # c="\xf0\x9f\x8d\xa3"
  (1..100).each do |i|
    screen.clear

    x, y = eval(ARGV.first)

    p = Point.new(x: x, y: y)
    screen.print(character: character, point: p)

    screen.flush
    sleep 0.01
  end

  screen.show_cursor

end

def serval
  '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
mmZabnrNDDWzN+OZ7TTrmkKY4jSFP6Vyyh1zqrmneZ55rXmPBcMixGKFRaPFq6n6UxOnbpp6cepX
SzvLTMt9lg+slKyCrFZYNVu9sTa1ZluXW9+0odn42Sy1abJ5bWtmy7WtsL1rR7cLtVtt12b3xd7B
XmhfZ9/voO+Q5LDD4Y6jsmOE4zrHS04EJy+npU4tTh+d7Z1znY84/+Vi7pLhcsDlxTSjadxp+6b1
uuq6slz3uHa7Md2S3Ha7dbvruLPcK92feOh5cDz2ezz3NPFM9zzo+crL0kvoddzrvbez92LvVh/M
x9+n0KfDV8k3xrfM97Gfrl+qX63foL+d/0L/1gBCQHDApoA7gZqB7MCawMEgh6DFQeeCqcFRwWXB
T0JMQ4QhzaFoaFDo5tCHYQZh/LDGcBAeGL45/FGEUUR2xG/TidMjppdPfxZpFbko8mIUPWpO1IGo
4Wiv6A3RD2KMY0QxbbHysTNja2Lfx/nEFcd1x0+NXxx/NUE9gZfQlEhKjE3cnzg0w3fG1hl9M+1m
Fsy8Pcto1vxZl2erz86cfXKO/BzWnKNJhKS4pANJn1nhrErWUHJg8o7kQbY3exv7JceDs4XTz3Xl
FnOfp7imFKe8SHVN3Zzan+aeVpI2wPPmlfFepwek70p/nxGeUZUxmhmXWZ9FzkrKOsFX4mfwz83V
mjt/bpfATFAg6M52zt6aPSgMFu7PQXJm5TTlKsOtTrvIWPSTqCfPLa8878O82HlH5yvO589vX2C6
YO2C5/l++b8sxBeyF7Yt0lm0fFHPYs/Fe5YgS5KXtC3VW7pqad8y/2XVyynLM5b/vsJyRfGKdyvj
Vjav0ly1bFXvT/4/1RbIFQgL7qx2Wb1rDb6Gt6Zjrc3a7Wu/FnIKrxRZFpUUfV7HXnflZ6ufS38e
XZ+yvmOD/YaKjcSN/I23N7lvqi5WLM4v7t0curlhC3NL4ZZ3W+dsvVxiW7JrG2WbaFt3aUhp03b9
7Ru3fy5LK7tV7lVev0Njx9od73dydl6v8Kio26W5q2jXp9283Xf3+O9pqDSsLNlL3Ju399m+2H0X
f3H8pWa/+v6i/V+q+FXd1ZHV52ocamoOaBzYUIvWimr7D8482HnI51BTnXndnnpGfdFhcFh0+I9f
k369fST4SNtRx6N1xwyO7ThOP17YgDQsaBhsTGvsbkpo6joRdKKt2aX5+G8Wv1W16LSUn1Q5ueEU
5dSqU6On808PtQpaB86knultm9P24Gz82Zvnpp/rOB98/tIFvwtnL3pePH3J9VLLZefLJ644Xmm8
an+1od2u/fjvdr8f77DvaLjmcK2p06mzuWta16nr7tfP3PC5ceFm4M2rt8Judd2OuX33zsw73Xc5
d1/cy7z3+n7e/ZEHyx4SHhY+UnhU8ljjceW/TP5V323ffbLHp6f9SdSTB73s3pdPc55+7lv1jPas
5Ln285oX1i9a+v36O/+Y8UffS8HLkYGCPxX/3PHK+NWxvzz+ah+MH+x7LXw9+mbdW7W3Ve9s37UN
RQw9Hs4aHnlf+EHtQ/VHx48XP8V9ej4y7zPpc+kXky/NX4O/PhzNGh0VsIQsyVYAgxVNSQHgTRUA
tAS4d4DnOIqc9PwlKYj0zCgh8E8sPaNJij0AVR4AxCwDIATuUSpgNYBMhXfx9jvaA6A2NhN1rOSk
2FhLc1HhKYbwYXT0rSYApGYAvghHR0d2jo5+2QfF3gOgNVt67hMXItzj7zYRU0c7BfxY/g0e1mtC
I0S39wAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAAgRpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADx4
OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IlhNUCBDb3JlIDUuNC4w
Ij4KICAgPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJk
Zi1zeW50YXgtbnMjIj4KICAgICAgPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIKICAgICAg
ICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iCiAgICAgICAg
ICAgIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIj4KICAgICAgICAg
PGV4aWY6UGl4ZWxZRGltZW5zaW9uPjM4MDwvZXhpZjpQaXhlbFlEaW1lbnNpb24+CiAgICAgICAg
IDxleGlmOlBpeGVsWERpbWVuc2lvbj4zODA8L2V4aWY6UGl4ZWxYRGltZW5zaW9uPgogICAgICAg
ICA8dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPgogICAgICA8L3JkZjpEZXNj
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
DwAAAABJRU5ErkJggg=='
end

main()

