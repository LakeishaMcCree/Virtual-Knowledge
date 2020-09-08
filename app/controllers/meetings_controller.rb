class MeetingsController < ApplicationController
    
    before_action :set_meeting, except: [:index, :new, :create]
    before_action :must_be_admin, only: [:active_sessions] 

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

    def edit
        @meeting = Meeting.find_by_id(params[:id])
    end

    def create
        @blog = current_user.meetings.create(meeting_params)
        if 
            @meeting.save
            user_meetings_path(@meeting)
        else
            render :new
        end 
    end

    def update
        if @meetings.update(meeting_params)
            redirect_to user_meeting_path(current_user, @meeting)
        else
            render :edit
        end
    end

    def destroy
        @meeting.destroy
        redirect_to user_meetings_path(current_user)
    end

    def active_sessions
        @active_sessions = Meeting.where("end_time > ?", Time.now)
    end

    private
    
    def meeting_params
        params.require(:meeting).permit(:title, :start_time, :end_time)
    end

    def set_meeting
        @meeting = Meeting.find_by_id(params[:id])
    end

    

    #def must_be_admin
        #unless current_user.admin?
            #redirect_to meetings_path, alert: "You don't have access to this page"
        #end
    #end
end
