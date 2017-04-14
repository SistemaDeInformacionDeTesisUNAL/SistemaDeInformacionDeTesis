class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]

  # GET /contributions
  # GET /contributions.json

  def index
  #  @contributions = Contribution.all
    @page=1
    @per_page=10

    #recibe el id de tag
    @tag=params[:tag]

    #recibe el id del grupo
    @group=params[:group]

    #almacena todos los tags
    @tags = Tag.all

    #almacena todos los grupos
    @groups = InvestigationGroup.all

    #almacena todas las contribuciones por tags
    @contributions = Contribution.contribution_by_tag_name(:group => @group,:tag => @tag, :page => @page, :per_page => @per_page)

    if @contributions.count < @per_page then
      @totalPages=1
    else
      @totalPages=@contributions.count/@per_page
    end

    if (1..@totalPages)===params[:page].to_i
      @page= params[:page].to_i
      @contributions = Contribution.contribution_by_tag_name(:tag => @tag, :page => @page, :per_page => @per_page)
    end
    #Esta variable retorna todas las contribuciones
    #@contributions = Contribution.load_contributions( :page => @page ,:per_page => @per_page)
    #Esta variable retorna las contribuciones despues de buscarlas por un tag
    #@contributions = Contribution.contribution_by_tag_name(:name => @name, :page => @page, :per_page => @per_page)
    #Esta variable retorna una lista con los tags
    #2)
    #Retorna los colaboradores de una contribucion
    @collaborators = Contribution.user_by_contribution(:ids => @ids)

    #3)
    #Esta variable retorna las ubicaciones de una contribucion
    @ubications = Contribution.ubications(:ids => @ids, :page => @page, :per_page => @per_page)

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
