class MeetingsController < ApplicationController
    
    before_action :set_meeting, except: [:index, :new, :create] 

    def index
        #if current_user
            @meetings = Meeting.all 
        #else
            #@meetings = current_user.meetings.where(user_id: current_user)
        #end
    end

    def show
        @user = User.find_by_id(params[:id])
        @meeting = Meeting.find_by_id(params[:id])
        @comment = Comment.new
    end

    def new
        @meeting = Meeting.new
    end

    def edit # /blogs/:id/edit
        @meeting = Meeting.find_by_id(params[:id])
    end

    def create
        @meeting = Meeting.new(meeting_params)
        @meeting.user_id = current_user.id 
        if 
            @meeting.save
            user_meetings_path(@meeting)
        else
            render :new
        end 
    end

    def update #patch /blogs/:id
        if @meeting.update(meeting_params)
            redirect_to user_meeting_path(current_user, @meeting)
        else
            render :edit
        end
    end

    def destroy
        @meeting.destroy
        redirect_to user_meetings_path(current_user)
    end


    private
    
    def set_meeting
        @meeting = Meeting.find_by_id(params[:id])
    end

    def meeting_params
        params.require(:meeting).permit(:name, :start_time, :end_time, :user_id)
    end

    

    

    #def must_be_admin
        #unless current_user.admin?
            #redirect_to meetings_path, alert: "You don't have access to this page"
        #end
    #end
end
