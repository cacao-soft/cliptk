# https://wiki.documentfoundation.org/Documentation/BASIC_Guide#Introduction_to_the_API
servmng = WIN32OLE.new("com.sun.star.ServiceManager")
libre = servmng.createInstance("com.sun.star.frame.Desktop")

file_path = File.expand_path("test.ods")
file_url = "file:///#{file_path}"

doc = libre.CurrentComponent  # 開いているものを取得
unless doc
  # 新規作成
  if File.exist?(file_path)
    doc = libre.loadComponentFromURL(file_url, "_blank", 0, [])
  else
    doc = libre.loadComponentFromURL("private:factory/scalc", "_blank", 0, [])
  end
end

sheets = doc.getSheets
puts sprintf("シート数 %d : シート名リスト %s", sheets.Count, sheets.getElementNames)
if sheets.hasByName("sheet1")
  sheet = sheets.getByName("sheet1")
else
  sheet = sheets.getByIndex(0)
end
p sheet.Name

doc.CurrentController().setActiveSheet(sheet)
sheet.getCellByposition(5, 0).String = "品名"
sheet.getCellRangeByPosition(6, 1, 7, 2).setDataArray([["金額","a"],[123, 323]])

sheet.getCellRangeByName("A1").setValue(1245)
sheet.getCellRangeByName("A2").Value = 1245
sheet.getCellRangeByName("A3").Formula = "1245"
sheet.getCellRangeByName("A4").Formula = 1245
sheet.getCellRangeByName("A5").Formula = "=1245"
 
sheet.getCellRangeByName("B1:D2").setDataArray([%w[1行 2行], [11, 22], %w[true false]])

if doc.isModified
  if doc.hasLocation && !doc.isReadOnly
    doc.store
  else
    doc.storeAsURL(file_url, [])
  end
end

# LibreOffice を終了する (以下コメントアウトするとウィンドウが残る)
doc.close(true)
libre.terminate
