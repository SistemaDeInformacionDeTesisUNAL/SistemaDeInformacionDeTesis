class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :exception

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @Owner=InvestigationGroup.teacher_group_owner(:id => @event.investigation_group.id)
  end

  # GET /events/new
  def new
    @groups=[]
    TeacherInvestigationGroup.load_groups_belong(:ids => current_teacher.id).each do |grupo|
      @groups.push(grupo.investigation_group)
    end
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @groups=[]
    TeacherInvestigationGroup.load_groups_belong(:ids => current_teacher.id).each do |grupo|
      @groups.push(grupo.investigation_group)
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
        EventTeacher.create!( event_id: @event.id, teacher_id: current_teacher.id )
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    if student_signed_in?
      EventStudent.create!( event_id: params[:id], teacher_id: current_student.id )
      redirect_to events_path
    end
    if teacher_signed_in?
      EventTeacher.create!( event_id: params[:id], teacher_id: current_teacher.id )
      redirect_to events_path
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :start_time, :end_time, :localization, :description, :investigation_group_id)
  end
end
