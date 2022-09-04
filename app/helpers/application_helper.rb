module ApplicationHelper

  # bootstrapのアイコンを生成するメソッド
  def icon(icon_name)
    tag.i(class: ["bi", "bi-#{icon_name}"])
  end

  # bootstrapの「アイコン＋文字列」を生成するメソッド
  def icon_with_text(icon_name, text)
    tag.span(icon(icon_name), class: "me-2") + tag.span(text)
  end

end
