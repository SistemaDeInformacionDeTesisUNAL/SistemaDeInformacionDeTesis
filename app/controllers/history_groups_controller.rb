class HistoryGroupsController < ApplicationController
  before_action :set_history_group, only: [:show, :edit, :update, :destroy]

  # GET /history_groups
  # GET /history_groups.json
  def index
    @history_groups = HistoryGroup.all
  end

  # GET /history_groups/1
  # GET /history_groups/1.json
  def show
  end

  # GET /history_groups/new
  def new
    @history_group = HistoryGroup.new
  end

  # GET /history_groups/1/edit
  def edit
  end

  # POST /history_groups
  # POST /history_groups.json
  def create
    @history_group = HistoryGroup.new(history_group_params)

    respond_to do |format|
      if @history_group.save
        format.html { redirect_to @history_group, notice: 'History group was successfully created.' }
        format.json { render :show, status: :created, location: @history_group }
      else
        format.html { render :new }
        format.json { render json: @history_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /history_groups/1
  # PATCH/PUT /history_groups/1.json
  def update
    respond_to do |format|
      if @history_group.update(history_group_params)
        format.html { redirect_to @history_group, notice: 'History group was successfully updated.' }
        format.json { render :show, status: :ok, location: @history_group }
      else
        format.html { render :edit }
        format.json { render json: @history_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /history_groups/1
  # DELETE /history_groups/1.json
  def destroy
    @history_group.destroy
    respond_to do |format|
      format.html { redirect_to history_groups_url, notice: 'History group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history_group
      @history_group = HistoryGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def history_group_params
      params.require(:history_group).permit(:bonding_date, :exit_date, :investigation_group_id, :student_id, :teacher_id)
    end
end
