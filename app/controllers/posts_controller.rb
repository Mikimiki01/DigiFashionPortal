class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:index, :show]
  include Pagy::Backend
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /posts or /posts.json
  def index
    @posts = Post.order(created_at: :asc)
    @pagy, @posts = pagy_countless(@posts, items: 1)
    @tags = Tag.all
  end

  def discover
    @posts = Post.all
    @tags = Tag.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = @post.comments.build
    @tags = @post.tags
  end

  def myposts
    @posts = Post.all
    @tags = Tag.all
  end

  # GET /posts/new
  def new
    @post = Post.new
    
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    # 画像が存在する場合のみVisionを呼び出す
    # ["", "XXXX", "YYYY"]　=> ["XXXX", "YYYY"]
    # images = post_params[:images].??????
    # images.first
    #if post_params[:images].present? && post_params[:images].last.present?
      #tags = Vision.get_image_data(post_params[:images].last)
    #end
    
    # 画像が存在する場合のみVisionを呼び出す
  images = post_params[:images].reject(&:blank?)
  tags = []

  if images.present?
    tags = Vision.get_image_data(images.last).take(3) # 最大3つのタグを取得
  end

    respond_to do |format|
      if @post.save
        tags.each do |tag_name|
          # 既存のタグを探すか、新しいタグを作成する
          tag = Tag.find_or_create_by(name: tag_name)
          # PostTag を使用して、投稿とタグの間の関係を作成する
          @post.post_tags.create(tag: tag)
        end if tags

        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /posts/1 or /posts/1.json
  def destroy
  @post.comments.destroy_all
  @post.likes.destroy_all
  @post.destroy

  respond_to do |format|
    format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
    format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :description, :keywords, :user_id, images: [])
  end
  
  def record_not_found
    redirect_to posts_url, alert: "指定された投稿が見つかりませんでした。"
  end
  
end
