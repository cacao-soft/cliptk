# パスの区切り文字を変更
File::SEPARATOR = "\\"

# Excel 起動
Excel = WIN32OLE.new('Excel.Application')

module XL
  # 定数の読み込み
  WIN32OLE.const_load(Excel, self)
end

class << Excel
  def open(filename, auto_close = true)
    path = File.expand_path(filename)
    if File.exist?(path)
      book = self.Workbooks.Open(path)
    else
      book = self.Workbooks.Add
      book.SaveAs(path)
    end
    def book.file_path = File.join(self.Path, self.Name)
    return book unless block_given?
    begin
      yield book
    ensure
      if auto_close
        book.Save
        book.Close
        nil
      else
        book
      end
    end
  end

  def quit!
    self.DisplayAlerts = false
    self.Quit
  end
end

# Excel 表示
Excel.Visible = true

# ファイルがあれば開き、無ければ新規作成
Excel.open("test.xlsx") do |book|
  p book.Worksheets(1).Cells(1, 1).Text
  p book.file_path
end

# 新しいブックを追加
book = Excel.Workbooks.Add
# 最初のシートを取得
sheet = book.Worksheets(1)

# 配列の値をセルに設定
sheet.Range("A1:C3").Value = [[1, 2, 3], [6, "あいうえお"], [4, 5]]
# セルの値を配列で取得
p sheet.Range("A1:C3").Value

# シート名を変更
sheet.Name = "シート名"

# ブックを閉じる
book.Close(false)

# エクセルが非表示か、開かれているブックが無ければ終了する
if !Excel.Visible || Excel.Workbooks.Count == 0
  Excel.quit!
end
