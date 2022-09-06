class ClimbingPlan < Prawn::Document
  def initialize
    super(page_size: 'A4') #新規PDF作成
    font_families.update('JP' => { normal: 'app/assets/fonts/ipaexm.ttf', bold: 'app/assets/fonts/ipaexg.ttf' })
    font 'JP'
    stroke_axis #座標を表示

    text "登山計画書 (登山届)", size: 20, align: :center
    move_down 20

    submit_to = [["◯◯警察署", "御中"]]
    table submit_to, column_widths: [150, 35] do
      cells.borders = [:bottom]
    end
    move_down 20

    # bounding_box([0, cursor], width: 180) do
    #   # 周りに枠線をつける
    #   text "御中", indent_paragraphs: 150
    #   stroke_bounds
    # end
    info = [
      [{content: "<b>目的の山域・山名</b>", colspan: 2, inline_format: true}, {content: "白馬岳", colspan: 4}],
      [{content: "<b>山行期間</b>", colspan: 2, inline_format: true}, "10/25", "〜",{content: "10/26", colspan: 2}],
      [{content: "役割", rowspan: 2}, {content: "氏名", rowspan: 2}, "生年月日", {content: "性別", rowspan: 2}, "現住所", "緊急連絡先(間柄)" ],
      ["年齢", "電話番号", "電話番号"],
      [{content: "CL", rowspan: 2}, {content: "小林 宏紀", rowspan: 2}, "1988.08.20", {content: "男", rowspan: 2}, "愛知県春日井市西本町2-11-2", "小林◯◯（母）" ],
      ["34歳", "090-2342-5598", "090-1234-5678"],
      [{content: "", rowspan: 2}, {content: "", rowspan: 2}, "", {content: "", rowspan: 2}, "", "" ],
      ["", "", ""],
      [{content: "", rowspan: 2}, {content: "", rowspan: 2}, "", {content: "", rowspan: 2}, "", "" ],
      ["", "", ""],
      [{content: "", rowspan: 2}, {content: "", rowspan: 2}, "", {content: "", rowspan: 2}, "", "" ],
      ["", "", ""],
      [{content: "", rowspan: 2}, {content: "", rowspan: 2}, "", {content: "", rowspan: 2}, "", "" ],
      ["", "", ""],
      [{content: "", rowspan: 2}, {content: "", rowspan: 2}, "", {content: "", rowspan: 2}, "", "" ],
      ["", "", ""]
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

    move_down 20

    # text "<u>◎ 所属している山岳会・サークル</u>", size: 14 ,inline_format: true
    group_title = [["◎", "所属している山岳会・サークル"]]
    table group_title, column_widths: [25, 210] do
      cells.borders = [:bottom]
      cells.size = 14

      cells.border_bottom_width = 1
    end
    move_down 10
    group = [
      [{content: "<b>所属:</b> ◯◯山岳会", inline_format: true}, "", ""],
      [{content: "<b>団体名:</b> 大人のワンダーフォーゲル部", inline_format: true}, "", {content: "<b>救援体制:</b> ", inline_format: true}],
      [{content: "<b>代表者:</b> ", inline_format: true}, "", {content: "<b>緊急連絡先:</b> ", inline_format: true}],
      [{content: "<b>代表者住所:</b> ", inline_format: true}, "", {content: "<b>住所:</b> ", inline_format: true}],
      [{content: "<b>代表者電話:</b> ", inline_format: true}, "", {content: "<b>電話番号:</b> ", inline_format: true}]
    ]

    table group, cell_style: {height: 25},
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
      ["(1) 10/25", "◯◯登山口--◯◯大雪渓--◯◯小屋--白馬岳山頂--白馬山荘"],
      ["(2) 10/26", "白馬山荘--◯◯尾根--◯◯池--◯◯登山口"],
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
      ["エスケープルート\n(荒天・非常時対策)", ""]
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
      ["基本食料", ""],
      ["非常食", ""],
      ["野営器具", ""],
      ["行動器具", ""],
      ["通信機器", ""],
      ["その他", ""]
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
