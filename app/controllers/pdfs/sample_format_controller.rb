module Pdfs
  class SampleFormatController < ApplicationController
    def index
      respond_to do |format|
        format.pdf do
          sample_format = Pdfs::SampleFormat.new().render
          send_data sample_format,
            filename: "登山計画書フォーマット.pdf",
            type: 'application/pdf',
            disposition: 'inline' # 外すとダウンロード
        end
      end
    end
  end
end
