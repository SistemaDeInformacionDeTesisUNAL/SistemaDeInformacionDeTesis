class InvestigationGroupsController < ApplicationController
  before_action :set_investigation_group, only: [:show, :edit, :update, :destroy]

  # GET /investigation_groups
  # GET /investigation_groups.json
  def index
  #  @investigation_groups = InvestigationGroup.all


    #listar grupos por tag en especifico
    @investigation_groups = InvestigationGroup.investigation_group_by_tag_name(:tag=> params[:tag])

    #lista de tags
  #  @tags_list= Tag.load_tag_names
    #listar grupos por eventos
  #  @investigation_groups = InvestigationGroup.load_groups()
    #listar grupos por tag en especifico
  #  @investigation_tags = InvestigationGroup.investigation_group_by_tag_name(:name=> params[:name])
    #Listar las contribuciones de un grupo de investigacion
  #  @investigation_contr = InvestigationGroup.contributions_group(:ids => params[:ids])
    #listar el profesor owner del grupo
  #  @owner_teacher = InvestigationGroup.teacher_group_owner(:ids => params[:ids])
    #Listar profesores del grupo
  #  @teachers_group = InvestigationGroup.teachers_group(:ids => params[:ids])
  end

  # GET /investigation_groups/1
  # GET /investigation_groups/1.json
  def show
    #Owner
    @Owner=InvestigationGroup.teacher_group_owner(:id => params[:id])
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

    respond_to do |format|
      if @investigation_group.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investigation_group
      @investigation_group = InvestigationGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def investigation_group_params
      params.require(:investigation_group).permit(:name, :create_date, :description,:image)
    end
end
