class P5Controller < ActionController::Base
  def index
    @p5_files = Dir.glob("app/javascript/p5/*").map { |file| File.basename(file, ".js") }
    @p5_files.delete("p5")
    session[:p5_file] = params[:file] unless params[:file].nil?
    session[:p5_file] ||= @p5_files.first if session[:p5_file].nil?
    @p5_file = session[:p5_file]
    @p5_file_content = File.read("app/javascript/p5/#{@p5_file}.js")

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    session[:p5_file] = params[:file]
    redirect_to action: 'index'
  end
end