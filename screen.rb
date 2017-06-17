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

class Point
  attr_accessor :x, :y

  def initialize(x:, y:)
    self.x = x
    self.y = y
  end
end

