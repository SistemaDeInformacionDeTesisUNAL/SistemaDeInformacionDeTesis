class TeacherInvestigationGroupsController < ApplicationController
  before_action :set_teacher_investigation_group, only: [:show, :edit, :update, :destroy]

  # GET /teacher_investigation_groups
  # GET /teacher_investigation_groups.json
  def index
    @teacher_investigation_groups = TeacherInvestigationGroup.all
  end

  # GET /teacher_investigation_groups/1
  # GET /teacher_investigation_groups/1.json
  def show
  end

  # GET /teacher_investigation_groups/new
  def new
    @teacher_investigation_group = TeacherInvestigationGroup.new
  end

  # GET /teacher_investigation_groups/1/edit
  def edit
  end

  # POST /teacher_investigation_groups
  # POST /teacher_investigation_groups.json
  def create
    @teacher_investigation_group = TeacherInvestigationGroup.new(teacher_investigation_group_params)

    respond_to do |format|
      if @teacher_investigation_group.save
        format.html { redirect_to @teacher_investigation_group, notice: 'Teacher investigation group was successfully created.' }
        format.json { render :show, status: :created, location: @teacher_investigation_group }
      else
        format.html { render :new }
        format.json { render json: @teacher_investigation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teacher_investigation_groups/1
  # PATCH/PUT /teacher_investigation_groups/1.json
  def update
    respond_to do |format|
      if @teacher_investigation_group.update(teacher_investigation_group_params)
        format.html { redirect_to @teacher_investigation_group, notice: 'Teacher investigation group was successfully updated.' }
        format.json { render :show, status: :ok, location: @teacher_investigation_group }
      else
        format.html { render :edit }
        format.json { render json: @teacher_investigation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teacher_investigation_groups/1
  # DELETE /teacher_investigation_groups/1.json
  def destroy
    @teacher_investigation_group.destroy
    respond_to do |format|
      format.html { redirect_to teacher_investigation_groups_url, notice: 'Teacher investigation group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher_investigation_group
      @teacher_investigation_group = TeacherInvestigationGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_investigation_group_params
      params.require(:teacher_investigation_group).permit(:teacher_id, :investigation_group_id, :rol, :state, :teacher_investigation_group_param)
    end
end
