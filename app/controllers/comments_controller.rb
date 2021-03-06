class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.build(comment_params)
        @comment.save
        render :create
    end

    def edit
        @comment = current_user.comments.find(params[:id])
    end

    def update
        @comment = current_user.comments.find(params[:id])
        @comment.update(comment_update_params)
    end

    def destroy
        @comment = current_user.comments.find(params[:id])
        @comment.destroy!
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(post_id: params[:post_id])
    end

    def  comment_update_params
        params.require(:comment).permit(:body)
    end
end
