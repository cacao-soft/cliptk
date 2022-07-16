#
# [MZ] ツクール -> テキストエディタ -> ツクール
#

=begin

  １．MZ のイベントやイベントコマンドをクリップボードにコピー
  ２．cliptk を実行し、テキストエディタにペースト
  ３．テキストをコピー
  ４．cliptk にこのファイルをドラッグ＆ドロップ
      もしくは、cliptk txt2ev.rb を実行
  ５．ツクールのエディタにペースト

=end

Clipboard << CF_MZ_AUTO << Clipboard.data

=begin

  Clipboard << データ
    クリップボードにデータを書き込み
  
  Clipboard << format << データ
    形式を指定してクリップボードにデータを書き込み
    AUTO 以外は複数可能 (Clipboard << format << format << データ)
    
    CF_XP_EVENT,  CF_XP_EVENT_PAGE,  CF_XP_EVENT_COMMAND
    CF_VX_EVENT,  CF_VX_EVENT_PAGE,  CF_VX_EVENT_COMMAND
    CF_VXA_EVENT, CF_VXA_EVENT_PAGE, CF_VXA_EVENT_COMMAND
    CF_MV_EVENT,  CF_MV_EVENT_PAGE,  CF_MV_EVENT_COMMAND
    CF_MZ_EVENT,  CF_MZ_EVENT_PAGE,  CF_MZ_EVENT_COMMAND
    
    CF_MV_AUTO, CF_MZ_AUTO

=end
