class InvestigationGroupsController < ApplicationController
  before_action :set_investigation_group, only: [:show, :edit, :update, :destroy]

  # GET /investigation_groups
  # GET /investigation_groups.json
  def index
  #  @investigation_groups = InvestigationGroup.all
    @page=1
    @per_page=10
    @totalPages=InvestigationGroup.countGroups/@per_page
    if (1..@totalPages)===params[:page].to_i
      @page= params[:page].to_i
    end
    #lista de tags
    @tags_list= Tag.load_tag_names
    #listar grupos por eventos
    @investigation_groups = InvestigationGroup.load_groups(:page=> @page ,:per_page=>@per_page)
    #listar grupos por tag en especifico
    @investigation_tags = InvestigationGroup.investigation_group_by_tag_name(:name=> @name,:page=> @page ,:per_page=>@per_page)
    #Listar las contribuciones de un grupo de investigacion
    @investigation_contr = InvestigationGroup.contributions_group(:ids => @ids, :page=> @page ,:per_page=>@per_page)
    #listar el profesor owner del grupo
    @owner_teacher = InvestigationGroup.teacher_group_owner(:ids => @ids, :page=> @page ,:per_page=>@per_page)
    #Listar profesores del grupo
    @teachers_group = InvestigationGroup.teachers_group(:ids => @ids, :page=> @page ,:per_page=>@per_page)
  end

  # GET /investigation_groups/1
  # GET /investigation_groups/1.json
  def show
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
