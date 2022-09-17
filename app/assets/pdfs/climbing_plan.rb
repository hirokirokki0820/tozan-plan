class ClimbingPlan < Prawn::Document
  def initialize(plan)
    super(page_size: 'A4') #新規PDF作成

    @plan = plan
    @companions = @plan.companions.order(role: 'ASC')
    @schedules = @plan.plan_schedules.order(date: 'ASC')
    @club = @plan.plan_club
    @equipment = @plan.plan_equipment
    @escape = @plan.plan_escape

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
    # 登山者一覧（@companions）情報を配列に格納
    role = [] # 役割
    full_name = [] # 氏名
    birthday = [] # 生年月日
    gender = [] # 性別
    age = [] #年齢
    address = [] #住所
    phone_number = [] #電話番号
    emergency_contact = [] #緊急連絡先
    emergency_number = [] #緊急連絡先の電話番号
    if @companions.present?
      @companions.each do |companion|
        (role << companion.role) unless companion.role == "X"
        full_name << companion.full_name
        birthday << companion.birthday.to_s.split('-').join('.')
        gender << companion.gender
        age << "#{companion.age}歳"
        address << companion.address
        phone_number << companion.phone_number
        emergency_contact << companion.emergency_contact
        emergency_number << companion.emergency_number
      end
    end

    # 入山日と下山日を変数に代入
    start_day = @plan.start_day.strftime('%m/%d')
    last_day = @plan.last_day.strftime('%m/%d')
    if start_day == last_day
      last_day = ""
    end

    info = [
      [{content: "<b>目的の山域・山名</b>", colspan: 2, inline_format: true}, {content: @plan.destination , colspan: 4}],

      [{content: "<b>山行期間</b>", colspan: 2, inline_format: true}, "#{start_day}" , "#{last_day.blank? ? "" : "〜" }",{content: "#{last_day}", colspan: 2}],

      [{content: "役割", rowspan: 2}, {content: "氏名", rowspan: 2}, "生年月日", {content: "性別", rowspan: 2}, "現住所", "緊急連絡先(間柄)" ],
      ["年齢", "電話番号", "電話番号"],

      #------------- 1人目 --------------
      [{content: "#{role[0]}", rowspan: 2}, {content: "#{full_name[0]}", rowspan: 2}, "#{birthday[0]}", {content: "#{gender[0]}", rowspan: 2}, "#{address[0]}", "#{emergency_contact[0]}" ],
      ["#{age[0]}", "#{phone_number[0]}", "#{emergency_number[0]}"],

      #------------- 2人目 --------------
      [{content: "#{role[1]}", rowspan: 2}, {content: "#{full_name[1]}", rowspan: 2}, "#{birthday[1]}", {content: "#{gender[1]}", rowspan: 2}, "#{address[1]}", "#{emergency_contact[1]}" ],
      ["#{age[1]}", "#{phone_number[1]}", "#{emergency_number[1]}"],

      #------------- 3人目 --------------
      [{content: "#{role[2]}", rowspan: 2}, {content: "#{full_name[2]}", rowspan: 2}, "#{birthday[2]}", {content: "#{gender[2]}", rowspan: 2}, "#{address[2]}", "#{emergency_contact[2]}" ],
      ["#{age[2]}", "#{phone_number[2]}", "#{emergency_number[2]}"],

      #------------- 4人目 --------------
      [{content: "#{role[3]}", rowspan: 2}, {content: "#{full_name[3]}", rowspan: 2}, "#{birthday[3]}", {content: "#{gender[3]}", rowspan: 2}, "#{address[3]}", "#{emergency_contact[3]}" ],
      ["#{age[3]}", "#{phone_number[3]}", "#{emergency_number[3]}"],

      #------------- 5人目 --------------
      [{content: "#{role[4]}", rowspan: 2}, {content: "#{full_name[4]}", rowspan: 2}, "#{birthday[4]}", {content: "#{gender[4]}", rowspan: 2}, "#{address[4]}", "#{emergency_contact[4]}" ],
      ["#{age[4]}", "#{phone_number[4]}", "#{emergency_number[4]}"],

      #------------- 6人目 --------------
      [{content: "#{role[5]}", rowspan: 2}, {content: "#{full_name[5]}", rowspan: 2}, "#{birthday[5]}", {content: "#{gender[5]}", rowspan: 2}, "#{address[5]}", "#{emergency_contact[5]}" ],
      ["#{age[5]}", "#{phone_number[5]}", "#{emergency_number[5]}"],
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
      columns(2).row(1).padding_left = 15
      columns(4).row(1).padding_left = 15
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

    # 所属情報（@club）を変数に代入
    belongs_to = "「無所属」" # 所属
    group_name = "" # 団体名
    representative_name = "" # 代表者
    representative_address = "" # 代表者住所
    representative_number = "" #代表者電話番号
    address = "" #住所
    phone_number = "" #電話番号
    emergency_contact = "" #緊急連絡先
    rescue_system = "" #救援体制
    if @club.present?
      belongs_to << @club.belongs_to
      group_name << @club.group_name
      representative_name << @club.representative_name
      representative_address << @club.representative_address
      representative_number << @club.representative_number
      address << @club.address
      phone_number << @club.phone_number
      emergency_contact << @club.emergency_contact
      rescue_system << @club.rescue_system
    end

    club = [
      [{content: "<b>所属:</b> #{belongs_to}", inline_format: true}, "", ""],
      [{content: "<b>団体名:</b> #{group_name}", inline_format: true}, "", {content: "<b>救援体制:</b> #{rescue_system}", inline_format: true}],
      [{content: "<b>代表者:</b> #{representative_name}", inline_format: true}, "", {content: "<b>緊急連絡先:</b> #{emergency_contact}", inline_format: true}],
      [{content: "<b>代表者住所:</b> #{representative_address}", inline_format: true}, "", {content: "<b>住所:</b> #{address}", inline_format: true}],
      [{content: "<b>代表者電話:</b> #{representative_number}", inline_format: true}, "", {content: "<b>電話番号:</b> #{phone_number}", inline_format: true}]
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
    schedule_date = []
    if @schedules.present?
      @schedules.each_with_index do |schedule, i|
        instance_variable_set("@schedule#{i+1}_tmp" , []) # 初期値の設定
        schedule_date << schedule.date.strftime('%m/%d')
        schedule.schedule_spots.each_with_index do |spot, j|
          str_spot = "#{spot.spot}"
          str_time = "(#{spot.time.strftime('%H:%M') if spot.time.present? })"
          if spot.time.nil?
            str_all = str_spot
          else
            str_all = str_spot + str_time
          end
          eval("@schedule#{i+1}_tmp[#{j}] = str_all")
        end
        eval("@schedule#{i+1} = @schedule#{i+1}_tmp.join(' ⇒ ')")
      end
    end

    schedule = [
      ["日程", "行動予定"],
      ["(1)  #{schedule_date[0]}", "#{@schedule1}"],
      ["(2)  #{schedule_date[1]}", "#{@schedule2}"],
      ["(3)  #{schedule_date[2]}", "#{@schedule3}"],
      ["(4)  #{schedule_date[3]}", "#{@schedule4}"],
      ["(5)  #{schedule_date[4]}", "#{@schedule5}"],
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

    escape = ""
    escape << @escape.escape_route

    escape_route = [
      ["エスケープルート\n(荒天・非常時対策)", "#{escape}"]
    ]
    table escape_route, cell_style: {height: 45},
    # max_width: 520
    column_widths: [100, 420] do
      cells.size = 10
      cells.leading = 3 # 文字の行間( line height )
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

    # 持ち物情報（@equipment）を変数に代入
    food = "" # 食糧
    emergency_food = "" # 非常食
    camp_equipment = "" # 野営器具
    climbing_equipment = "" # 行動器具
    wireless = "" # 通信機器
    others = "" # その他

    if @club.present?
      food = @equipment.food
      emergency_food = @equipment.emergency_food
      camp_equipment = @equipment.camp_equipment
      climbing_equipment = @equipment.climbing_equipment
      wireless = @equipment.wireless
      others = @equipment.others
    end
    equipment = [
      ["基本食料", "#{food}"],
      ["非常食", "#{emergency_food}"],
      ["野営器具", "#{camp_equipment}"],
      ["行動器具", "#{climbing_equipment}"],
      ["通信機器", "#{wireless}"],
      ["その他", "#{others}"]
    ]

    table equipment, cell_style: {height: 25},
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
