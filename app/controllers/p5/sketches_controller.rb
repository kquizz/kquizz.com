module P5
  class SketchesController < ApplicationController
    def show
      @p5_files = Dir.glob("app/javascript/p5/*").map { |file| File.basename(file, ".js") }
      @p5_files.delete("p5")
      @p5_file = @p5_files[params[:id].to_i]
      
      @p5_file_content = File.read("app/javascript/p5/#{@p5_file}.js")
      render 'p5/sketches/show'
    end

    def index
      get_p5_files
    end


    private 

    def get_p5_files
      @p5_files = Dir.glob("app/javascript/p5/*").map { |file| File.basename(file, ".js") }
      @p5_files.delete("p5")

      return @p5_files
    end
  end
end