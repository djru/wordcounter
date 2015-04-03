class WordcounterController < ApplicationController
  skip_before_action :verify_authenticity_token

  def count
    file = params[:text]
    if file.content_type != 'application/pdf'
      redirect_to :root, notice: 'file was not pdf'
    else
      opened_pdf = PDF::Reader.new file.tempfile
      contents = opened_pdf.pages.join(" ")
      @freqs = analyze(contents)
    end
  end

  def count_manual
    @freqs = analyze(params[:text_manual])
  end



end
