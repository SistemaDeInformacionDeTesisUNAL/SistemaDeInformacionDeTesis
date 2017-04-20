class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_student!
  # GET /contributions
  # GET /contributions.json

  def index
    @page=1
    @contributions = Contribution.all
    @per_page=10

    if @contributions.count < @per_page then
      @totalPages=1
    else
      @totalPages=@contributions.count/@per_page
    end

    if (1..@totalPages)===params[:page].to_i
      @page= params[:page].to_i

      @contributions = Contribution.all
    end

  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
  end

  # GET /contributions/new
  def new
    @contribution = Contribution.new
  end

  # GET /contributions/1/edit
  def edit
  end
  # POST /contributions
  # POST /contributions.json
  def create
    @contribution = Contribution.new(contribution_params)

    respond_to do |format|
      if @contribution.save
        format.html { redirect_to @contribution, notice: 'Contribution was successfully created.' }
        format.json { render :show, status: :created, location: @contribution }
      else
        format.html { render :new }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to @contribution, notice: 'Contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :edit }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy
    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to contributions_url, notice: 'Contribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

#Solicitar la ubicación de una contribución por su id
  def ubication_contribution
    @page=1
    @per_page=10
    @ids=params[:ids]
    @ubications = Contribution.ubications(:ids => @ids, :page => @page, :per_page => @per_page)
  end

#busqueda de todas las contribuciones por tags
 def all_contributions_tags

   @page=1
   @per_page=10
   #recibe el id de tag, grupo de investigacion o un state de la contribucion
   @tag=params[:tag]
   @group=params[:group]
   @state=params[:state]

   #almacena todos los tags ascendentemente
   @tags = Tag.all.order("name ASC")
   #almacena todos los grupos ascendentemente
   @groups = InvestigationGroup.all.order("name ASC")
   #almacena todas las contribuciones por tags
   @contributions = Contribution.contribution_by_tag_name(:state=>@state,:group => @group,:tag => @tag, :page => @page, :per_page => @per_page)

   if @contributions.count < @per_page then
     @totalPages=1
   else
     @totalPages=@contributions.count/@per_page
   end

   if (1..@totalPages)===params[:page].to_i
     @page= params[:page].to_i
     @contributions = Contribution.contribution_by_tag_name(:tag => @tag, :page => @page, :per_page => @per_page)
   end


 end

#busqueda de profesores por contribucion
  def teacher_contrib
    @ids=params[:ids]
    @teach= Contribution.teachers(:ids => @ids)
  end

  #busqueda de estudiantes por contribucion
    def student_contrib
      @ids=params[:ids]
      @stud= Contribution.students(:ids => @ids)
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribution_params
      params.require(:contribution).permit(:name, :publication_date, :description, :investigation_group_id, :file)
    end
end
