class TasksController < ApplicationController

    def index
        @pending_tasks = Task.get_by_status("Pednding")
        @completed_tasks = Task.get_by_status("Completed")
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.create(task_params(:name, :description, :user_id))
        @task.status = "Pending"
        @task.save
        @task.meeting.update_status
        redirect_to task_path(@task)
    end


    def edit
        @task = Task.find_by_id(params[:id])
    end

    def destroy
        @task = Task.find_by_id(params[:id]).destroy
        redirect_to tasks_path
    end
end
