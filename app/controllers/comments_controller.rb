class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comment = current_user.comments.build(comment_params)
        @comment.save
        render :create
    end

    private

    def comment_params
        params.require(:comment).permit(:body).merge(post_id: params[:post_id])
    end
end
