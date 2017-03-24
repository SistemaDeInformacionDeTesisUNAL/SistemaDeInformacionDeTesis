class EventTeachersController < ApplicationController
  before_action :set_event_teacher, only: [:show, :edit, :update, :destroy]

  # GET /event_teachers
  # GET /event_teachers.json
  def index
    @event_teachers = EventTeacher.all
  end

  # GET /event_teachers/1
  # GET /event_teachers/1.json
  def show
  end

  # GET /event_teachers/new
  def new
    @event_teacher = EventTeacher.new
  end

  # GET /event_teachers/1/edit
  def edit
  end

  # POST /event_teachers
  # POST /event_teachers.json
  def create
    @event_teacher = EventTeacher.new(event_teacher_params)

    respond_to do |format|
      if @event_teacher.save
        format.html { redirect_to @event_teacher, notice: 'Event teacher was successfully created.' }
        format.json { render :show, status: :created, location: @event_teacher }
      else
        format.html { render :new }
        format.json { render json: @event_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_teachers/1
  # PATCH/PUT /event_teachers/1.json
  def update
    respond_to do |format|
      if @event_teacher.update(event_teacher_params)
        format.html { redirect_to @event_teacher, notice: 'Event teacher was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_teacher }
      else
        format.html { render :edit }
        format.json { render json: @event_teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_teachers/1
  # DELETE /event_teachers/1.json
  def destroy
    @event_teacher.destroy
    respond_to do |format|
      format.html { redirect_to event_teachers_url, notice: 'Event teacher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_teacher
      @event_teacher = EventTeacher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_teacher_params
      params.require(:event_teacher).permit(:event_id, :teacher_id)
    end
end
