class UserContributionsController < ApplicationController
  before_action :set_user_contribution, only: [:destroy]

  # GET /user_contributions/new
  def new
    @contribution = Contribution.find(params[:contribution_id])
    @user_contribution = UserContribution.new
  end

  # POST /user_contributions
  # POST /user_contributions.json
  def create
    @user_contribution = UserContribution.new(user_contribution_params)
    @contribution = Contribution.find(@user_contribution.contribution_id)
    respond_to do |format|
      if @user_contribution.save
        format.html { redirect_to investigation_group_contribution_users_path(@contribution.investigation_group_id,@contribution.id), notice: 'User contribution was successfully created.' }
        format.json { render :show, status: :created, location: @user_contribution }
      else
        format.html { render :new }
        format.json { render json: @user_contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_contributions/1
  # DELETE /user_contributions/1.json
  def destroy
    @user_contribution.destroy
    respond_to do |format|
      format.html { redirect_to user_contributions_url, notice: 'User contribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_contribution
      @user_contribution = UserContribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_contribution_params
      params.require(:user_contribution).permit(:userable_type, :userable_id, :contribution_id)
    end
end
