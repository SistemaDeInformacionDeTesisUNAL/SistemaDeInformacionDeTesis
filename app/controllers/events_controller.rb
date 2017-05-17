class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]
  before_action :set_event_id, only: [:edit]
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
    @contribution_group = InvestigationGroup.find(params[:investigation_group_id])
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
        EventTeacher.create!( event_id: @event.id, teacher_id: current_teacher.id )
        EventMailer.rememberEmail(:user=>current_teacher,:event=>@event).deliver_later!(wait_until: @event.start_time.yesterday.midnight)
        #Send mail to all teachers in the group
        InvestigationGroup.teachers_group(:id => @event.investigation_group.id).each do |teacher|
          EventMailer.emailCreated(:user=>teacher,:event=>@event).deliver!
        end
        #Send mail to all students in the group
        @students=InvestigationGroup.students_group(:id => @event.investigation_group.id)
        if @students!=nil
          @students.each do |student|
            EventMailer.emailCreated(:user=>student,:event=>@event).deliver!
          end
        end
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
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

        #Send mail to all teachers in the group
        @event.teachers do |teacher|
          EventMailer.updateEmail(:user=>teacher,:event=>@event).deliver!
        end
        #Send mail to all students in the group
        @students=@event.students
        if @students!=nil
          @students.each do |student|
            EventMailer.updateEmail(:user=>student,:event=>@event).deliver!
          end
        end
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
      format.html { redirect_to events_path, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    @event=Event.find(params[:id])
    if student_signed_in?
      EventStudent.create!( event_id: params[:id], student_id: current_student.id )
      EventMailer.joinEmail(:user=>current_student,:event=>@event).deliver!
      EventMailer.rememberEmail(:user=>current_student,:event=>@event).deliver_later!(wait_until: @event.start_time.yesterday.midnight)
      redirect_to events_path
    end
    if teacher_signed_in?
      EventTeacher.create!( event_id: params[:id], teacher_id: current_teacher.id )
      EventMailer.joinEmail(:user=>current_teacher,:event=>@event).deliver!
      EventMailer.rememberEmail(:user=>current_teacher,:event=>@event).deliver_later!(wait_until: @event.start_time.yesterday.midnight)
      redirect_to events_path
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_event_id
    @event = Event.find(params[:event_id])
    @invGroup = InvestigationGroup.find(params[:investigation_group_id])
  end

  def event_params
    params.require(:event).permit(:name, :start_time, :end_time, :localization, :investigation_group_id, :description)
  end
end
