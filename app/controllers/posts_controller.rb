class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts or /posts.json
  def index
    @posts = Post.all.order("created_at DESC")
    @post = Post.new
    @top_five_posts = Like.top_five

    if user_signed_in?
      @user = current_user
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    if user_signed_in?
      @user = current_user
    end
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to posts_path, alert: "Post not created. You had missing fields in the form." }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if current_user == @post.user
        if @post.update(post_params)
          format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      else
        format.html {redirect_to @post, alert: "You are not the author of this post."}
      end 
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy

    if current_user == @post.user
      @post.destroy

      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully deleted.", status: 303 }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html {redirect_to @post, alert: "You are not the author of this post."}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:text, :title)
    end
end
