class ClimbingPlan < Prawn::Document
  def initialize(plan)
    super(page_size: 'A4') #新規PDF作成
    @plan = plan

    font_families.update('JP' => { normal: 'app/assets/fonts/ipaexm.ttf', bold: 'app/assets/fonts/ipaexg.ttf' })
    font 'JP'
    # stroke_axis #座標を表示
    text "登山計画書 (登山届)", size: 20, align: :center
    move_down 20

    submit_to = [[@plan.submit_to, "御中"]]
    table submit_to, column_widths: [150, 35] do
      cells.borders = [:bottom]
      cells.height = 30
      columns(0).size = 10
    end
    move_down 20

    # bounding_box([0, cursor], width: 180) do
    #   # 周りに枠線をつける
    #   text "御中", indent_paragraphs: 150
    #   stroke_bounds
    # end

    #---- 山域・山名、参考期間、および登山者一覧 ----
    info = [
      [{content: "<b>目的の山域・山名</b>", colspan: 2, inline_format: true}, {content: @plan.destination, colspan: 4}],

      [{content: "<b>山行期間</b>", colspan: 2, inline_format: true}, @plan.start_day.strftime('%m/%d'), "〜",{content: "#{@plan.last_day.strftime('%m/%d')}", colspan: 2}],

      [{content: "役割", rowspan: 2}, {content: "氏名", rowspan: 2}, "生年月日", {content: "性別", rowspan: 2}, "現住所", "緊急連絡先(間柄)" ],
      ["年齢", "電話番号", "電話番号"],

      #------------- 1人目 --------------
      [{content: "#{@plan.companions[0].role unless (@plan.companions[0].nil? || @plan.companions[0].role == "X")}", rowspan: 2}, {content: "#{@plan.companions[0].full_name unless @plan.companions[0].nil?}", rowspan: 2}, "#{@plan.companions[0].birthday.to_s.split('-').join('.') unless @plan.companions[0].nil?}", {content: "#{@plan.companions[0].gender unless @plan.companions[0].nil?}", rowspan: 2}, "#{@plan.companions[0].address unless @plan.companions[0].nil?}", "#{@plan.companions[0].emergency_contact unless @plan.companions[0].nil?}" ],
      ["#{@plan.companions[0].age.to_s + '歳' unless @plan.companions[0].nil?}", "#{@plan.companions[0].phone_number unless @plan.companions[0].nil?}", "#{@plan.companions[0].emergency_number unless @plan.companions[0].nil?}"],

      #------------- 2人目 --------------
      [{content: "#{@plan.companions[1].role unless (@plan.companions[1].nil? || @plan.companions[1].role == "X")}", rowspan: 2}, {content: "#{@plan.companions[1].full_name unless @plan.companions[1].nil?}", rowspan: 2}, "#{@plan.companions[1].birthday.to_s.split('-').join('.') unless @plan.companions[1].nil?}", {content: "#{@plan.companions[1].gender unless @plan.companions[1].nil?}", rowspan: 2}, "#{@plan.companions[1].address unless @plan.companions[1].nil?}", "#{@plan.companions[1].emergency_contact unless @plan.companions[1].nil?}" ],
      ["#{@plan.companions[1].age.to_s + '歳' unless @plan.companions[1].nil?}", "#{@plan.companions[1].phone_number unless @plan.companions[1].nil?}", "#{@plan.companions[1].emergency_number unless @plan.companions[1].nil?}"],

      #------------- 3人目 --------------
      [{content: "#{@plan.companions[2].role unless (@plan.companions[2].nil? || @plan.companions[2].role == "X")}", rowspan: 2}, {content: "#{@plan.companions[2].full_name unless @plan.companions[2].nil?}", rowspan: 2}, "#{@plan.companions[2].birthday.to_s.split('-').join('.') unless @plan.companions[2].nil?}", {content: "#{@plan.companions[2].gender unless @plan.companions[2].nil?}", rowspan: 2}, "#{@plan.companions[2].address unless @plan.companions[2].nil?}", "#{@plan.companions[2].emergency_contact unless @plan.companions[2].nil?}" ],
      ["#{@plan.companions[2].age.to_s + '歳' unless @plan.companions[2].nil?}", "#{@plan.companions[2].phone_number unless @plan.companions[2].nil?}", "#{@plan.companions[2].emergency_number unless @plan.companions[2].nil?}"],

      #------------- 4人目 --------------
      [{content: "#{@plan.companions[3].role unless (@plan.companions[3].nil? || @plan.companions[3].role == "X")}", rowspan: 2}, {content: "#{@plan.companions[3].full_name unless @plan.companions[3].nil?}", rowspan: 2}, "#{@plan.companions[3].birthday.to_s.split('-').join('.') unless @plan.companions[3].nil?}", {content: "#{@plan.companions[3].gender unless @plan.companions[3].nil?}", rowspan: 2}, "#{@plan.companions[3].address unless @plan.companions[3].nil?}", "#{@plan.companions[3].emergency_contact unless @plan.companions[3].nil?}" ],
      ["#{@plan.companions[3].age.to_s + '歳' unless @plan.companions[3].nil?}", "#{@plan.companions[3].phone_number unless @plan.companions[3].nil?}", "#{@plan.companions[3].emergency_number unless @plan.companions[3].nil?}"],

      #------------- 5人目 --------------
      [{content: "#{@plan.companions[4].role unless (@plan.companions[4].nil? || @plan.companions[4].role == "X")}", rowspan: 2}, {content: "#{@plan.companions[4].full_name unless @plan.companions[4].nil?}", rowspan: 2}, "#{@plan.companions[4].birthday.to_s.split('-').join('.') unless @plan.companions[4].nil?}", {content: "#{@plan.companions[4].gender unless @plan.companions[4].nil?}", rowspan: 2}, "#{@plan.companions[4].address unless @plan.companions[4].nil?}", "#{@plan.companions[4].emergency_contact unless @plan.companions[4].nil?}" ],
      ["#{@plan.companions[4].age.to_s + '歳' unless @plan.companions[4].nil?}", "#{@plan.companions[4].phone_number unless @plan.companions[4].nil?}", "#{@plan.companions[4].emergency_number unless @plan.companions[4].nil?}"],

      #------------- 6人目 --------------
      [{content: "#{@plan.companions[5].role unless (@plan.companions[5].nil? || @plan.companions[5].role == "X")}", rowspan: 2}, {content: "#{@plan.companions[5].full_name unless @plan.companions[5].nil?}", rowspan: 2}, "#{@plan.companions[5].birthday.to_s.split('-').join('.') unless @plan.companions[5].nil?}", {content: "#{@plan.companions[5].gender unless @plan.companions[5].nil?}", rowspan: 2}, "#{@plan.companions[5].address unless @plan.companions[5].nil?}", "#{@plan.companions[5].emergency_contact unless @plan.companions[5].nil?}" ],
      ["#{@plan.companions[5].age.to_s + '歳' unless @plan.companions[5].nil?}", "#{@plan.companions[5].phone_number unless @plan.companions[5].nil?}", "#{@plan.companions[5].emergency_number unless @plan.companions[5].nil?}"],
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

    sample = [
      [{content: "", rowspan: 2}, {content: "", rowspan: 2}, "", {content: "", rowspan: 2}, "", "" ],
      ["", "", ""],
    ]

    move_down 20

    # text "<u>◎ 所属している山岳会・サークル</u>", size: 14 ,inline_format: true

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
      [{content: "<b>団体名:</b> 大人のワンダーフォーゲル部", inline_format: true}, "", {content: "<b>救援体制:</b> ", inline_format: true}],
      [{content: "<b>代表者:</b> ", inline_format: true}, "", {content: "<b>緊急連絡先:</b> ", inline_format: true}],
      [{content: "<b>代表者住所:</b> ", inline_format: true}, "", {content: "<b>住所:</b> ", inline_format: true}],
      [{content: "<b>代表者電話:</b> ", inline_format: true}, "", {content: "<b>電話番号:</b> ", inline_format: true}]
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
