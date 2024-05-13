module Notes
  class NotesController < ApplicationController
    before_action :set_note, only: %i[ show edit update destroy ]

    # GET /notes or /notes.json
    def index
      @notes = Note.all.order(created_at: :desc)
    end

    # GET /notes/1 or /notes/1.json
    def show
    end

    # GET /notes/new
    def new
      @note = Note.new
    end

    # GET /notes/1/edit
    def edit
    end

    # POST /notes or /notes.json 
    def create
      @note = Note.new(note_params)
      @note.user = current_user;
        
       if current_user.nil?
        throw new Error("You must be logged in to create messages");
      end

      # binding.pry;

      respond_to do |format|
        if @note.save
          flash[:notice] = "Note created!"
          # format.html { render partial: 'new', notice: 'Note was successfully created.' }
          format.html {redirect_to notes_path, notice: 'Note was successfully created.'}
          format.turbo_stream
          format.json { render :show, status: :created, location: @note }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @note.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /notes/1 or /notes/1.json
    def update
      respond_to do |format|
        if @note.update(note_params)
          format.turbo_stream
          format.html { redirect_to notes_path, notice: 'Note was successfully created.' }
          format.json { render :show, status: :ok, location: @note }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @note.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /notes/1 or /notes/1.json
    def destroy
      # binding.pry
      @note.destroy!

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_note
        @note = Note.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def note_params
        params.require(:note).permit(:title, :body)
      end
  end
end
