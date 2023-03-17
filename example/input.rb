#
# 入力を受け取る
#

=begin

  コマンドライン引数を受け取る
    ARGV
  
  コンソールで一行入力
    gets
  
  コンソールで複数行を入力
    $stdin.readlines

=end


if ARGV.empty?
  # コマンドライン引数がなければ入力を実行
  print "半角数字で入力してください : "
  num = gets.to_i
  print "文字を入力してください : "
  str = gets.chomp
else
  # １つ目の引数を数値で取得
  num = ARGV[0].to_i
  # ２つ目の引数を文字列で取得
  str = ARGV[1]
end
puts "[ 取得結果：数値 #{num} 文字列 #{str} ]"
puts

# 複数行の入力を実行
puts "複数行の入力を受け取る (Ctrl + z で制御文字 SUB のみを入力で終了)"
p $stdin.readlines.map(&:chomp)
