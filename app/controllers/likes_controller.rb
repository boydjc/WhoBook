class LikesController < ApplicationController
  before_action :set_like, only: %i[ create ]

  # POST /likes
  def create
    @like = Like.new(like_params)

    respond_to do |format|
      if @like.save
        format.html { redirect_to post_url(@like.post) }
      else
        format.html { redirect_to post_url(@like.post), alert: "Error liking post" }
      end
    end
  end

  # DELETE /likes/1
  def destroy
    @like = Like.find(params[:id])

    @like.destroy

    respond_to do |format|
      format.html { redirect_to post_url(@like.post) }
      format.json { head :no_content }
    end
  end

  private
    def set_like
      @like = Like.new
    end
    # Only allow a list of trusted parameters through.
    def like_params
      params.permit(:user_id, :post_id)
    end
end
