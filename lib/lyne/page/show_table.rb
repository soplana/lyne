module Lyne::Page
  module ShowTable
    def show_table
      table = Kosi::Table.new({header: table_headers})
      print table.render([table_rows])
    end

    private
    def table_headers; [] end
    def table_rows;    [] end
  end
end
