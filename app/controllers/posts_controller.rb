class PostsController < ApplicationController
    def index 
        @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page]).per(15)
    end

    def new
        @post = Post.new
    end

    def create
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
end
