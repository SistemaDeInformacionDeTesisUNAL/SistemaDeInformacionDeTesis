class InvestigationGroupsController < ApplicationController
  before_action :set_investigation_group, only: [:show, :edit, :update, :destroy, :member, :updateMemberState, :updateMemberRol, :join, :contributionsGroup, :eventsGroup]

  # GET /investigation_groups
  # GET /investigation_groups.json
  def index
    #listar grupos por tag en especifico
    @investigation_groups = InvestigationGroup.load_groups
  end

  # GET /investigation_groups/1
  # GET /investigation_groups/1.json
  def show
    #Owner
    @allContributions=InvestigationGroup.contributions_group(:group_id => @investigation_group.id)
    @Owner=InvestigationGroup.teacher_group_owner(:id => @investigation_group.id)
    @Admins=InvestigationGroup.admins_group(:id => @investigation_group.id)
    @Teachers=InvestigationGroup.teachers_group(:id => @investigation_group.id)
    @Students=InvestigationGroup.students_group(:id => @investigation_group.id)
    if teacher_signed_in?
      @relation=InvestigationGroup.relationTeacherInvestigationGroup(:teacher_id => current_teacher.id,:investigation_group_id => @investigation_group.id)
    end
  end

  def contributionsGroup
  #  @contributions = Contribution.all
    #almacena todos los tags
    @tags = Tag.all.order("name ASC")
    #almacena todas las contribuciones por tags
    @contributions = InvestigationGroup.contributions_group(:group_id => @investigation_group.id)
  end

  def eventsGroup
    @events = InvestigationGroup.events_group(:group_id => @investigation_group.id)
  end

  # GET /investigation_groups/new
  def new
    @investigation_group = InvestigationGroup.new
  end

  # GET /investigation_groups/1/edit
  def edit
  end

  # POST /investigation_groups
  # POST /investigation_groups.json
  def create
    @investigation_group = InvestigationGroup.new(investigation_group_params)
    @investigation_group.create_date = DateTime.now
    respond_to do |format|
      if @investigation_group.save
        TeacherInvestigationGroup.create!( teacher_id: current_teacher.id, investigation_group_id: @investigation_group.id, rol: 2, state: 2 )
        format.html { redirect_to @investigation_group, notice: 'Investigation group was successfully created.' }
        format.json { render :show, status: :created, location: @investigation_group }
      else
        format.html { render :new }
        format.json { render json: @investigation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investigation_groups/1
  # PATCH/PUT /investigation_groups/1.json
  def update
    respond_to do |format|
      if @investigation_group.update(investigation_group_params)
        format.html { redirect_to @investigation_group, notice: 'Investigation group was successfully updated.' }
        format.json { render :show, status: :ok, location: @investigation_group }
      else
        format.html { render :edit }
        format.json { render json: @investigation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investigation_groups/1
  # DELETE /investigation_groups/1.json
  def destroy
    @investigation_group.destroy
    respond_to do |format|
      format.html { redirect_to investigation_groups_url, notice: 'Investigation group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    @Owner=InvestigationGroup.teacher_group_owner(:id => @investigation_group.id)
    if student_signed_in?
      @student = Student.find(current_student.id)
      @student.investigation_group_id = @investigation_group.id
      @student.state = 'Process'
      if @student.save!
        EventMailer.joinInvestigationEmail(:user=>current_student,:owner=>@Owner, :group => @investigation_group).deliver!
        redirect_to investigation_group_path(@investigation_group), notice: 'Student investigation group was successfully updated, Join.'
      end
    else
      if TeacherInvestigationGroup.create!( teacher_id: current_teacher.id, investigation_group_id: @investigation_group.id, rol: 0, state: 1 )
        EventMailer.joinInvestigationEmail(:user=>current_teacher,:owner=>@Owner, :group => @investigation_group).deliver!
        redirect_to investigation_group_path(@investigation_group), notice: 'Teacher investigation group was successfully updated, Join.'
      end
    end
  end

  def member
    @students=InvestigationGroup.students_group(:id => @investigation_group.id)
    @teacherMembers=TeacherInvestigationGroup.load_teachers(:ids => @investigation_group.id)
  end

  def updateMemberState
    @state = params[:member_investigation_group_param]
    if params[:type] == 'Student'
      @memState = Student.find(params[:ids])
    else
      @memState = TeacherInvestigationGroup.find(params[:ids])
    end
    @memState.state = @state
    if @memState.save!
      EventMailer.stateChangedInvestigationEmail(:user=>@memState, :group => @investigation_group, :state=>@state).deliver!
      redirect_to member_investigation_groups_path(@investigation_group), notice: 'Member investigation group was successfully updated, State.'
    end
  end

  def updateMemberRol
    @rol = params[:member_investigation_group_param]
    @memRol = TeacherInvestigationGroup.find(params[:ids])
    @memRol.rol = @rol
    if @memRol.save!
      EventMailer.rolChanged(:user=>@memRol, :group => @investigation_group, :rol=>@rol).deliver!
      redirect_to member_investigation_groups_path(@investigation_group), notice: 'Teacher investigation group was successfully updated, Rol.'
    end
  end

  def updateContributionState
    @state = params[:contribution_state]
    @contribution = Contribution.find(params[:ids])
    @contribution.state = @state

    @Students = Contribution.students(:id => @contribution.id)
    @Teachers = Contribution.teachers(:id => @contribution.id)

    if @contribution.save!
      @Students.each do |user|
        EventMailer.stateContributionChanged(:user=>user,:contribution=>@contribution, :group => @investigation_group, :state=>@state).deliver!
      end
      @Teachers.each do |user|
       EventMailer.stateContributionChanged(:user=>user,:contribution=>@contribution, :group => @investigation_group, :state=>@state).deliver!
     end
      redirect_to contributionsGroup_investigation_groups_path(@investigation_group), notice: 'Contribution was successfully updated, State.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investigation_group
      @investigation_group = InvestigationGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def investigation_group_params
      params.require(:investigation_group).permit(:name, :create_date, :description,:image,:member_investigation_group_param,:type,:contribution_state,:ids)
    end
end
