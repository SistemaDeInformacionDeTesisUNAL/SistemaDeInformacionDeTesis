class TagContributionsController < ApplicationController
  before_action :set_tag_contribution, only: [:show, :edit, :update, :destroy]

  # GET /tag_contributions
  # GET /tag_contributions.json
  def index
    @tag_contributions = TagContribution.all
  end

  # GET /tag_contributions/1
  # GET /tag_contributions/1.json
  def show
  end

  # GET /tag_contributions/new
  def new
    @tag_contribution = TagContribution.new
  end

  # GET /tag_contributions/1/edit
  def edit
  end

  # POST /tag_contributions
  # POST /tag_contributions.json
  def create
    @tag_contribution = TagContribution.new(tag_contribution_params)

    respond_to do |format|
      if @tag_contribution.save
        format.html { redirect_to @tag_contribution, notice: 'Tag contribution was successfully created.' }
        format.json { render :show, status: :created, location: @tag_contribution }
      else
        format.html { render :new }
        format.json { render json: @tag_contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tag_contributions/1
  # PATCH/PUT /tag_contributions/1.json
  def update
    respond_to do |format|
      if @tag_contribution.update(tag_contribution_params)
        format.html { redirect_to @tag_contribution, notice: 'Tag contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @tag_contribution }
      else
        format.html { render :edit }
        format.json { render json: @tag_contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tag_contributions/1
  # DELETE /tag_contributions/1.json
  def destroy
    @tag_contribution.destroy
    respond_to do |format|
      format.html { redirect_to tag_contributions_url, notice: 'Tag contribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_contribution
      @tag_contribution = TagContribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_contribution_params
      params.require(:tag_contribution).permit(:tag_id, :contribution_id)
    end
end
