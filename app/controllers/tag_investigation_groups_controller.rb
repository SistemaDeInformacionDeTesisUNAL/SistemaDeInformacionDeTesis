class TagInvestigationGroupsController < ApplicationController
  before_action :set_tag_investigation_group, only: [:show, :edit, :update, :destroy]

  # GET /tag_investigation_groups
  # GET /tag_investigation_groups.json
  def index
    @tag_investigation_groups = TagInvestigationGroup.all
  end

  # GET /tag_investigation_groups/1
  # GET /tag_investigation_groups/1.json
  def show
  end

  # GET /tag_investigation_groups/new
  def new
    @tag_investigation_group = TagInvestigationGroup.new
  end

  # GET /tag_investigation_groups/1/edit
  def edit
  end

  # POST /tag_investigation_groups
  # POST /tag_investigation_groups.json
  def create
    @tag_investigation_group = TagInvestigationGroup.new(tag_investigation_group_params)

    respond_to do |format|
      if @tag_investigation_group.save
        format.html { redirect_to @tag_investigation_group, notice: 'Tag investigation group was successfully created.' }
        format.json { render :show, status: :created, location: @tag_investigation_group }
      else
        format.html { render :new }
        format.json { render json: @tag_investigation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_investigation_groups/1
  # PATCH/PUT /tag_investigation_groups/1.json
  def update
    respond_to do |format|
      if @tag_investigation_group.update(tag_investigation_group_params)
        format.html { redirect_to @tag_investigation_group, notice: 'Tag investigation group was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag_investigation_group }
      else
        format.html { render :edit }
        format.json { render json: @tag_investigation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_investigation_groups/1
  # DELETE /tag_investigation_groups/1.json
  def destroy
    @tag_investigation_group.destroy
    respond_to do |format|
      format.html { redirect_to tag_investigation_groups_url, notice: 'Tag investigation group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_investigation_group
      @tag_investigation_group = TagInvestigationGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_investigation_group_params
      params.require(:tag_investigation_group).permit(:tag_id, :investigationGroup_id)
    end
end
