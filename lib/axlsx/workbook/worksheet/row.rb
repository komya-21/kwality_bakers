def add_cell(value = '', options = {})
  c = Cell.new(self, value, options)
  self << c
  worksheet.send(:update_column_info, self, [])
  c
end