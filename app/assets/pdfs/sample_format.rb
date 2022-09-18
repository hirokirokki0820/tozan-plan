class SampleFormat < Prawn::Document
  def initialize
    super(page_size: 'A4') #新規PDF作成
    # stroke_axis #座標を表示

    # 日本語フォントの読み込み
    font_families.update('JP' => { normal: 'app/assets/fonts/ipaexm.ttf', bold: 'app/assets/fonts/ipaexg.ttf' })
    font 'JP'

    text "登山計画書 (登山届)", size: 20, align: :center
    move_down 20

    submit_to = [["◯◯警察 △△課", "御中"]]
    table submit_to, column_widths: [150, 35] do
      cells.borders = [:bottom]
      cells.height = 30
      columns(0).size = 10
    end
    move_down 20

    #-------- 山域・山名、山行期間 --------
    info = [
      [{content: "<b>目的の山域・山名</b>", colspan: 2, inline_format: true}, {content: "北アルプス ◯◯岳", colspan: 4}],

      [{content: "<b>山行期間</b>", colspan: 2, inline_format: true}, "10/09", "〜",{content: "10/10", colspan: 2}],

      [{content: "役割", rowspan: 2}, {content: "氏名", rowspan: 2}, "生年月日", {content: "性別", rowspan: 2}, "現住所", "緊急連絡先(間柄)" ],
      ["年齢", "電話番号", "電話番号"]
    ]

    table info, cell_style: {height: 30},
    # widthの最大値 520
    column_widths: [30, 80, 80, 30, 200, 100] do
      cells.size = 10
      row(0).columns(2).size = 12
      row(1).columns(2..4).size = 12
      row(0..1).height = 25
      row(1).columns(2).borders = [:left, :top, :bottom]
      row(1).columns(3).borders = [:top, :bottom]
      row(1).columns(4).borders = [:top, :bottom, :right]
      # 枠線を太くする
      row(0).border_top_width = 2
      row(0).border_bottom_width = 2
      row(1).border_bottom_width = 2
      row(3).border_bottom_width = 2
      columns(0).row(0..3).border_left_width = 2
      columns(-1).row(0..3).border_right_width = 2
      row(2..3).font_style = :bold
    end

    #-------- 登山者名簿一覧 --------
    companions = [
      [{content: "CL", rowspan: 2}, {content: "山田太郎", rowspan: 2}, "1988.08.01", {content: "男", rowspan: 2}, "愛知県名古屋市中区栄111", "山田一郎（父）" ],
      ["34歳", "090-XXXX-XXXX", "090-XXXX-XXXX"],
      [{content: "SL", rowspan: 2}, {content: "鈴木一郎", rowspan: 2}, "1992.04.01", {content: "男", rowspan: 2}, "愛知県名古屋市中区栄222", "鈴木花子（母）" ],
      ["30歳", "090-XXXX-XXXX", "090-XXXX-XXXX"],
      [{content: "", rowspan: 2}, {content: "山田花子", rowspan: 2}, "1998.05.20", {content: "女", rowspan: 2}, "愛知県名古屋市中区栄333", "山田幸子（母）" ],
      ["24歳", "090-XXXX-XXXX", "052-XXX-XXXX"],
      [{content: "", rowspan: 2}, {content: "佐藤美咲", rowspan: 2}, "2000.10.10", {content: "女", rowspan: 2}, "愛知県名古屋市中区栄444", "佐藤美紀（母）" ],
      ["22歳", "090-XXXX-XXXX", "052-XXX-XXXX"],
      [{content: "", rowspan: 2}, {content: "", rowspan: 2}, "", {content: "", rowspan: 2}, "", "" ],
      ["", "", ""],
      [{content: "", rowspan: 2}, {content: "", rowspan: 2}, "", {content: "", rowspan: 2}, "", "" ],
      ["", "", ""]
    ]

    table companions, cell_style: {height: 30},
    # widthの最大値 520
    column_widths: [30, 80, 80, 30, 200, 100] do
      cells.size = 10
    end
    move_down 20

    #---- ◎ 所属している山岳会・サークル ----
    club_title = [["◎", "所属している山岳会・サークル"]]
    table club_title, column_widths: [25, 210] do
      cells.borders = [:bottom]
      cells.size = 14
      cells.border_bottom_width = 1
    end
    move_down 10
    club = [
      [{content: "<b>所属:</b> ◯◯山岳会", inline_format: true}, "", ""],
      [{content: "<b>団体名:</b> △△サークル", inline_format: true}, "", {content: "<b>救援体制:</b> あり(◯名)", inline_format: true}],
      [{content: "<b>代表者:</b> 田中太郎", inline_format: true}, "", {content: "<b>緊急連絡先:</b> 高橋太郎", inline_format: true}],
      [{content: "<b>代表者住所:</b> 愛知県名古屋市中区栄123", inline_format: true}, "", {content: "<b>住所:</b> 愛知県名古屋市中区栄345", inline_format: true}],
      [{content: "<b>代表者電話:</b> 052-XXX-XXXX", inline_format: true}, "", {content: "<b>電話番号:</b> 090-XXXX-XXXX", inline_format: true}]
    ]

    table club, cell_style: {height: 25},
    column_widths: [250, 30, 240] do
      cells.size = 10
      cells.borders = [:bottom]
      cells.border_lines = [:dotted]
      row(3).height = 35
      columns(1).borders = []
      row(0).columns(-1).borders = []
    end
    move_down 20

    schedule_title = [["◎", "行動スケジュール"]]
    table schedule_title, column_widths: [25, 125] do
      cells.borders = [:bottom]
      cells.size = 14
    end
    move_down 10

    schedule = [
      ["日程", "行動予定"],
      ["(1) 10/09", "◯◯登山口(07:00) ⇒ △△尾根(10:30) ⇒ □□分岐点(12:00) ⇒ ◯◯岳山頂(13:00) ⇒ △△小屋（泊）(15:00)"],
      ["(2) 10/10", "△△小屋(08:00) ⇒ □□尾根分岐(10:30) ⇒ ◯◯岳山頂(12:00) ⇒ 3合目(14:00) ⇒ △△登山口（下山）(15:30)"],
      ["(3)", ""],
      ["(4)", ""],
      ["(5)", ""],
    ]

    table schedule, cell_style: {height: 30},
    column_widths: [120, 400] do
      cells.size = 10
      row(0).border_top_width = 2
      row(0).border_bottom_width = 2
      columns(0).row(0..5).border_left_width = 2
      columns(-1).row(0..5).border_right_width = 2
      row(-1).border_bottom_width = 2

    end

    escape_route = [
      ["エスケープルート\n(荒天・非常時対策)", "山小屋へ避難、または○○尾根を経由して△△登山口へ下山"]
    ]
    table escape_route, cell_style: {height: 50},
    # max_width: 520
    column_widths: [120, 400] do
      cells.size = 10
      row(0).border_top_width = 2
      row(0).border_bottom_width = 2
      columns(0).row(0).border_left_width = 2
      columns(-1).row(0).border_right_width = 2

    end
    move_down 20

    belongings_title = [["◎", "持ち物"]]
    table belongings_title, column_widths: [25, 55] do
      cells.borders = [:bottom]
      cells.size = 14
    end
    move_down 10

    belongings = [
      ["基本食料", "基本食（2日分）、行動食（2日分）"],
      ["非常食", "カロリーメイト（3日分）"],
      ["野営器具", "テント（2〜3人用）x 2、ツェルト x 2"],
      ["行動器具", "ロープ"],
      ["通信機器", "携帯電話、無線(430MHz)x1"],
      ["その他", "ガスカートリッジ x 3"]
    ]

    table belongings, cell_style: {height: 25},
    column_widths: [120, 400] do
      cells.size = 10
      row(0).border_top_width = 2
      columns(0).row(0..5).border_left_width = 2
      columns(-1).row(0..5).border_right_width = 2
      row(-1).border_bottom_width = 2
    end
    move_down 20

    image_title = [["◎", "概念図"]]
    table image_title, column_widths: [25, 55] do
      cells.borders = [:bottom]
      cells.size = 14
    end
    move_down 10

    bounding_box([0, cursor], width: 520, height: 220) do
      # 周りに枠線をつける
      transparent(1) { stroke_bounds }
    end

  end
end
