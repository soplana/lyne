class String
  def byte_size
    hankaku = self.scan(/[ -~｡-ﾟ]/).size
    zenkaku = (self.size - hankaku)*2
    hankaku + zenkaku
  end
end

module Lyne::Util
  class TerminalTable
    def initialize header
      @header = header
      @table  = []
    end

    def render rows
      rows = rows.map{|r| r.nil? ? '' : r}
      if @header.size > rows.size
        rows = rows + Array.new(@header.size - rows.size, '')
      else
        @header = @header + Array.new(rows.size - @header.size, '')
      end

      table       = width(@header.zip(rows))
      width_list  = table.map{|t|t[0]}
      table_width = width_list.inject(&:+)
      @width = "+#{width_list.map{|w| "#{'-'*w}+"}.join}"

      puts_row

      rows = [@header] + [rows]
      rows.each_with_index do |row, i|
        table_row = ''
        row.each_with_index do |r, j|
          blank_size = width_list[j] - r.byte_size
          table_row += "#{r}#{" "*blank_size}|"
        end
        puts "|#{table_row}"
        puts_row if i == 0
      end
      puts_row
    end

    private
    def puts_header
      puts "|#{@header.join(' ')}|"
      puts "|#{@rows[0].join(' ')}|"
    end

    def puts_row
      puts @width
    end

    def width table
      table.inject([]) do |new_table, old_table|
        new_table << old_table.unshift(old_table.map{|t| t.nil? ? 0 : t.byte_size}.max)
        new_table
      end
    end
  end
end

module Lyne::Page
  module ShowTable
    def show_table
      Lyne::Util::TerminalTable.new(table_headers).render(table_rows)
    end

    private
    def table_headers; [] end
    def table_rows;    [] end
  end
end
