class PostsController < ApplicationController
    def index 
      @posts = if current_user
      current_user.feed.includes(:user).page(params[:page]).order(created_at: :desc)
      else
        Post.all.includes(:user).page(params[:page]).order(created_at: :desc)
      end
    end

    def search
      @posts = Post.body_contain(search_post_params[:body]).includes(:user).page(params[:page])
    end

    def new
        @post = Post.new
    end

    def create
      return redirect_to login_path unless current_user
        @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to posts_path, success: '投稿しました'
      else
        flash.now[:danger] = '投稿に失敗しました'
        render :new
      end
    end

    def edit
        @post = current_user.posts.find(params[:id])
    end

    def update
        @post = current_user.posts.find(params[:id])
      if @post.update(post_params)
        redirect_to posts_path, success: '投稿を更新しました'
      else
        flash.now[:danger] = '投稿の更新に失敗しました'
        reder :edit
      end
    end

    def show
        @post = Post.find(params[:id])
        @comments = @post.comments.includes(:user).order(created_at: :desc)
        @comment = Comment.new
    end

    def destroy
        @post = current_user.posts.find(params[:id])
        @post.destroy!
        redirect_to posts_path, success: '投稿を削除しました'
    end

    private

    def post_params
        # images:[]とすることで、JSON形式でparamsを受け取る
        params.require(:post).permit(:body, {images: []})
    end

    def search_post_params
      params.fetch(:q, {}).permit(:body)
    end
end