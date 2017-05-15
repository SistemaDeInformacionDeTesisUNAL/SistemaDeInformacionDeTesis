class EventStudentsController < ApplicationController
  before_action :set_event_student, only: [:show, :edit, :update, :destroy]

  # GET /event_students
  # GET /event_students.json
  def index
@event_students=[]
    EventStudent.where(:student_id=>current_student.id).each do |evento|
      @event_students<<Event.find(evento.event_id)
    end
  end

  # GET /event_students/1
  # GET /event_students/1.json
  def show
  end

  # GET /event_students/new
  def new
    @event_student = EventStudent.new
  end

  # GET /event_students/1/edit
  def edit
  end

  # POST /event_students
  # POST /event_students.json
  def create
    @event_student = EventStudent.new(event_student_params)

    respond_to do |format|
      if @event_student.save
        format.html { redirect_to @event_student, notice: 'Event student was successfully created.' }
        format.json { render :show, status: :created, location: @event_student }
      else
        format.html { render :new }
        format.json { render json: @event_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_students/1
  # PATCH/PUT /event_students/1.json
  def update
    respond_to do |format|
      if @event_student.update(event_student_params)
        format.html { redirect_to @event_student, notice: 'Event student was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_student }
      else
        format.html { render :edit }
        format.json { render json: @event_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_students/1
  # DELETE /event_students/1.json
  def destroy
    @event_student.destroy
    respond_to do |format|
      format.html { redirect_to event_students_url, notice: 'Event student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_student
      @event_student=[]
          EventStudent.where(:student_id=>current_student.id).each do |evento|
            @event_student<<Event.find(evento.event_id)
          end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_student_params
      params.require(:event_student).permit(:event_id, :student_id)
    end
end
