class CompaignsController < ApplicationController
  def index
    @compaigns = Compaign.all
  end

  def show
    @candidates = Compaign.find_by_id(params[:id]).candidates.sort { |a,b| b.counted <=> a.counted }
  end
end
