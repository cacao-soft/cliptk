#
# アイテム、武器、防具の名称リストをエクセルで作成する
#
File::SEPARATOR = "\\"
Excel = WIN32OLE.new('Excel.Application')

filename = "test.xlsx"
path = File.expand_path(filename)

begin
  book =
    if File.exist?(path)
      Excel.Workbooks.Open(path)
    else
      Excel.Workbooks.Add
    end
    
  sheet = nil
  sheet_name = "マスタ"
  1.upto(book.Worksheets.Count) do |i|
    if book.Worksheets(i).Name == sheet_name
      sheet = book.Worksheets(i)
      break
    end
  end
  sheet ||= book.Worksheets.Add
  
  sheet.Range("A:A").Clear
  sheet.Range("A1:A3").Value = %w[アイテム 武器 防具].zip
  sheet.Range("B:D").Clear
  [
    load_data("Data/Items.rvdata2"),
    load_data("Data/Weapons.rvdata2"),
    load_data("Data/Armors.rvdata2")
  ]
  .each_with_index do |list,i|
    sheet
      .Cells(1, 2 + i)
      .Resize(list.size - 1)
      .Value = list[1..-1].map { [_1.name] }
  end
rescue => e
  Excel.DisplayAlerts = false
  Excel.Quit
  raise e
else
  Excel.Visible = true
end
