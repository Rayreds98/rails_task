class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy, :assign]
  before_action :correct_user, only: [:edit, :destroy]

  def index
    @tasks = Task.index_all.page(params[:page])
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def mytask
    @tasks = Task.index_all.where(user_id: params[:id]).page(params[:page])
  end

  def assign
  end

  def create
    @task = current_user.tasks.build(task_params)
      if @task.save
        redirect_to @task, notice: 'Task was successfully created.'
      else
        render :new
      end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :user_id)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_path if @task.nil?
  end
end
