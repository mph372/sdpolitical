class PinnedContestsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @contest = Contest.friendly.find(params[:id])  # Changed from Contest.find
    @pinned_contest = current_user.pinned_contests.build(contest: @contest)
    
    if @pinned_contest.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, notice: 'Contest pinned successfully') }
        format.json { render json: { status: 'success', message: 'Contest pinned' } }
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, alert: 'Unable to pin contest') }
        format.json { render json: { status: 'error', message: 'Unable to pin contest' } }
      end
    end
  end
  
  def destroy
    @contest = Contest.friendly.find(params[:id])  # Add this line
    @pinned_contest = current_user.pinned_contests.find_by(contest: @contest)  # Changed to find by contest
    
    if @pinned_contest&.destroy
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, notice: 'Contest unpinned') }
        format.json { render json: { status: 'success', message: 'Contest unpinned' } }
      end
    else
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path, alert: 'Unable to unpin contest') }
        format.json { render json: { status: 'error', message: 'Unable to unpin contest' } }
      end
    end
  end
  
  def reorder
    params[:contest_ids].each_with_index do |contest_id, index|
      current_user.pinned_contests.find_by(contest_id: contest_id)&.update(pin_order: index + 1)
    end
    
    head :ok
  end
end