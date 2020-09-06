class MeetingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_meeting, only: [:show, :edit, :update, :destroy]
    before_action :must_be_admin, only: [:active_sessions] 

    def index
        if current_user.admin?
            @meetings = Meeting.all 
        else
            @meetings = current_user.meetings.where(user_id: current_user)
        end
    end

    def show
        @comment = Comment.new
    end

    def new
        @meeting = Meeting.new
    end

    def edit

    end

    def create
        @meeting = Meeting.new(meeting_params)
        @meeting.user_id = current_user.id 
    end

    def update
        respond_to do |format|
            if @meeting.update(meeting_params)
                format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
                #format.json { render :show, status: :ok, location: @meeting}
            else
                format.html { render :edit }
                #format.json { render json: @meeting.errors, status:unprocessable_entity }
            end
        end
    end

    def destroy
        @meeting.destroy
        respond_to do |format|
            format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.'}
            #format.json { head :no_content }
        end
    end

    def active_sessions
        @active_sessions = Meeting.where("end_time > ?", Time.now)
    end

    private
    def set_meeting
        @meeting = Meeting.find(params[:id])
    end

    def meeting_params
        params.require(:meeting).permit(:name, :start_time, :end_time)
    end

    def must_be_admin
        unless current_user.admin?
            redirect_to meetings_path, alert: "You don't have access to this page"
        end
    end
end
