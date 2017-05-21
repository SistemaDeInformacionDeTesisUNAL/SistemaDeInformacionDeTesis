class HistoryGroupsController < ApplicationController

  def index
    @history_groups = HistoryGroup.all
  end

end
