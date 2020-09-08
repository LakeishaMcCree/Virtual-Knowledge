class CommentsController < ApplicationController

    before_action :set_meeting
    before_action :set_comment, only: [:edit, :update, :show, :destroy]
    
    def new
        @comment = Comment.new
    end

    def create
       @meeting = Meeting.find_by_id(params[:id])
            @comment = @meeting.comments.create(params[:comment].permit(:name, :comment))
        redirect_to meeting_path(@meeting)
    end

    def destroy 
        @meeting = Meeting.find_by_id(params[:id])
        @comment = @meeting.comments.find(params[:id])
        @comment.destroy
        redirect_to meeting_path(@meeting)
    end

end
