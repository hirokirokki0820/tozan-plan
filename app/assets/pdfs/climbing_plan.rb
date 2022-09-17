class ClimbingPlan < Prawn::Document
  def initialize(plan)
    super(page_size: 'A4') #新規PDF作成
    @plan = plan
    @companions = @plan.companions.order(role: 'ASC')
    @schedules = @plan.plan_schedules.order(date: 'ASC')

    # 日本語フォントの読み込み
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
      [{content: "#{@companions[0].role unless (@companions[0].nil? || @companions[0].role == "X")}", rowspan: 2}, {content: "#{@companions[0].full_name unless @companions[0].nil?}", rowspan: 2}, "#{@companions[0].birthday.to_s.split('-').join('.') unless @companions[0].nil?}", {content: "#{@companions[0].gender unless @companions[0].nil?}", rowspan: 2}, "#{@companions[0].address unless @companions[0].nil?}", "#{@companions[0].emergency_contact unless @companions[0].nil?}" ],
      ["#{@companions[0].age.to_s + '歳' unless @companions[0].nil?}", "#{@companions[0].phone_number unless @companions[0].nil?}", "#{@companions[0].emergency_number unless @companions[0].nil?}"],

      #------------- 2人目 --------------
      [{content: "#{@companions[1].role unless (@companions[1].nil? || @companions[1].role == "X")}", rowspan: 2}, {content: "#{@companions[1].full_name unless @companions[1].nil?}", rowspan: 2}, "#{@companions[1].birthday.to_s.split('-').join('.') unless @companions[1].nil?}", {content: "#{@companions[1].gender unless @companions[1].nil?}", rowspan: 2}, "#{@companions[1].address unless @companions[1].nil?}", "#{@companions[1].emergency_contact unless @companions[1].nil?}" ],
      ["#{@companions[1].age.to_s + '歳' unless @companions[1].nil?}", "#{@companions[1].phone_number unless @companions[1].nil?}", "#{@companions[1].emergency_number unless @companions[1].nil?}"],

      #------------- 3人目 --------------
      [{content: "#{@companions[2].role unless (@companions[2].nil? || @companions[2].role == "X")}", rowspan: 2}, {content: "#{@companions[2].full_name unless @companions[2].nil?}", rowspan: 2}, "#{@companions[2].birthday.to_s.split('-').join('.') unless @companions[2].nil?}", {content: "#{@companions[2].gender unless @companions[2].nil?}", rowspan: 2}, "#{@companions[2].address unless @companions[2].nil?}", "#{@companions[2].emergency_contact unless @companions[2].nil?}" ],
      ["#{@companions[2].age.to_s + '歳' unless @companions[2].nil?}", "#{@companions[2].phone_number unless @companions[2].nil?}", "#{@companions[2].emergency_number unless @companions[2].nil?}"],

      #------------- 4人目 --------------
      [{content: "#{@companions[3].role unless (@companions[3].nil? || @companions[3].role == "X")}", rowspan: 2}, {content: "#{@companions[3].full_name unless @companions[3].nil?}", rowspan: 2}, "#{@companions[3].birthday.to_s.split('-').join('.') unless @companions[3].nil?}", {content: "#{@companions[3].gender unless @companions[3].nil?}", rowspan: 2}, "#{@companions[3].address unless @companions[3].nil?}", "#{@companions[3].emergency_contact unless @companions[3].nil?}" ],
      ["#{@companions[3].age.to_s + '歳' unless @companions[3].nil?}", "#{@companions[3].phone_number unless @companions[3].nil?}", "#{@companions[3].emergency_number unless @companions[3].nil?}"],

      #------------- 5人目 --------------
      [{content: "#{@companions[4].role unless (@companions[4].nil? || @companions[4].role == "X")}", rowspan: 2}, {content: "#{@companions[4].full_name unless @companions[4].nil?}", rowspan: 2}, "#{@companions[4].birthday.to_s.split('-').join('.') unless @companions[4].nil?}", {content: "#{@companions[4].gender unless @companions[4].nil?}", rowspan: 2}, "#{@companions[4].address unless @companions[4].nil?}", "#{@companions[4].emergency_contact unless @companions[4].nil?}" ],
      ["#{@companions[4].age.to_s + '歳' unless @companions[4].nil?}", "#{@companions[4].phone_number unless @companions[4].nil?}", "#{@companions[4].emergency_number unless @companions[4].nil?}"],

      #------------- 6人目 --------------
      [{content: "#{@companions[5].role unless (@companions[5].nil? || @companions[5].role == "X")}", rowspan: 2}, {content: "#{@companions[5].full_name unless @companions[5].nil?}", rowspan: 2}, "#{@companions[5].birthday.to_s.split('-').join('.') unless @companions[5].nil?}", {content: "#{@companions[5].gender unless @companions[5].nil?}", rowspan: 2}, "#{@companions[5].address unless @companions[5].nil?}", "#{@companions[5].emergency_contact unless @companions[5].nil?}" ],
      ["#{@companions[5].age.to_s + '歳' unless @companions[5].nil?}", "#{@companions[5].phone_number unless @companions[5].nil?}", "#{@companions[5].emergency_number unless @companions[5].nil?}"],
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

    # 行動予定の変数化
    if @schedules.present?
      @schedules.each_with_index do |schedule, i|
        instance_variable_set("@plan#{i+1}_schedule_tmp" , []) # 初期値の設定
        if schedule.present?
          schedule.schedule_spots.each_with_index do |spot, j|
            str_spot = "#{spot.spot}"
            str_time = "(#{spot.time.strftime('%H:%M') if spot.time.present? })"
            if spot.time.nil?
              str_all = str_spot
            else
              str_all = str_spot + str_time
            end
            eval("@plan#{i+1}_schedule_tmp[#{j}] = str_all")
          end
        end
        eval("@plan#{i+1}_schedule = @plan#{i+1}_schedule_tmp.join(' ⇒ ')")
      end
    end

    schedule = [
      ["日程", "行動予定"],
      ["(1)  #{@schedules[0].date.strftime('%m/%d') unless @schedules[0].nil?}", "#{@plan1_schedule}"],
      ["(2)  #{@schedules[1].date.strftime('%m/%d') unless @schedules[1].nil?}", "#{@plan2_schedule}"],
      ["(3)  #{@schedules[2].date.strftime('%m/%d') unless @schedules[2].nil?}", "#{@plan3_schedule}"],
      ["(4)  #{@schedules[3].date.strftime('%m/%d') unless @schedules[3].nil?}", "#{@plan4_schedule}"],
      ["(5)  #{@schedules[4].date.strftime('%m/%d') unless @schedules[4].nil?}", "#{@plan5_schedule}"],
    ]

    table schedule, cell_style: {height: 45},
    column_widths: [100, 420] do
      cells.size = 10
      cells.leading = 3 # 文字の行間( line height )
      row(0).size = 12
      row(1..-1).columns(0).size = 12
      row(0).border_top_width = 2
      row(0).border_bottom_width = 2
      columns(0).row(0..5).border_left_width = 2
      columns(-1).row(0..5).border_right_width = 2
      row(-1).border_bottom_width = 2

    end

    escape_route = [
      ["エスケープルート\n(荒天・非常時対策)", ""]
    ]
    table escape_route, cell_style: {height: 45},
    # max_width: 520
    column_widths: [100, 420] do
      cells.size = 10
      row(0).border_top_width = 2
      row(0).border_bottom_width = 2
      columns(0).row(0).border_left_width = 2
      columns(-1).row(0).border_right_width = 2

    end
    move_down 10

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
    column_widths: [100, 420] do
      cells.size = 10
      row(0).border_top_width = 2
      columns(0).row(0..5).border_left_width = 2
      columns(-1).row(0..5).border_right_width = 2
      row(-1).border_bottom_width = 2
    end
    move_down 10

    image_title = [["◎", "概念図"]]
    table image_title, column_widths: [25, 55] do
      cells.borders = [:bottom]
      cells.size = 14
    end
    move_down 10

    bounding_box([0, cursor], width: 520, height: 200) do
      # 周りに枠線をつける
      transparent(1) { stroke_bounds }
    end

  end
end
