class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]
  before_action :set_contribution_id, only: [:users, :newUser]

  # GET /contributions
  # GET /contributions.json

  def index
  #  @contributions = Contribution.all
    #almacena todos los tags
    @tags = Tag.all.order("name ASC")
    #almacena todos los grupos
    @groups = InvestigationGroup.all.order("name ASC")
    #almacena todas las contribuciones por tags
    @contributions = Contribution.contributions
  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
    @Students = Contribution.students(:id => params[:id])
    @Teachers = Contribution.teachers(:id => params[:id])
  end

  # GET /contributions/new
  def new
    @contribution_group = InvestigationGroup.find(params[:investigation_group_id])
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
      @contribution.state = 2
      if @contribution.save
        format.html { redirect_to contributionsGroup_investigation_groups_path(@contribution.investigation_group_id), notice: 'Contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribution }
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
        format.html { redirect_to contributionsGroup_investigation_groups_path, notice: 'Contribution was successfully updated.' }
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

  def users
    @Students = Contribution.students(:id => params[:contribution_id])
    @Teachers = Contribution.teachers(:id => params[:contribution_id])
  end

  def newUser
    @Teachers=TeacherInvestigationGroup.load_teachers(:ids => params[:investigation_group_id])
    @Students=InvestigationGroup.students_group(:id => params[:investigation_group_id])
  end

  def createUser
    @user_contribution = UserContribution.new
    @user_contribution.contribution_id = params[:contr]
    @user_contribution.userable_type = params[:type]
    @user_contribution.userable_id = params[:ids]
    if @user_contribution.save
      redirect_to investigation_group_contribution_users_path, notice: 'Contribution was successfully updated.'
    else
      render :root
    end
  end

  def deleteUser
    @user_contribution = Contribution.user_contribution( :type=>params[:type], :ids=>params[:ids], :contr=>params[:contr] )
    @user_contribution.each do |us|
      us.destroy
    end
    redirect_to investigation_group_contribution_users_path, notice: 'Contribution was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
    end

    def set_contribution_id
      @contribution = Contribution.find(params[:contribution_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribution_params
      params.require(:contribution).permit(:name, :publication_date, :description, :investigation_group_id, :file, :ids, :type, :contr)
    end
end
