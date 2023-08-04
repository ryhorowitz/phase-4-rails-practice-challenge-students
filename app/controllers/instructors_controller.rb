class InstructorsController < ApplicationController
  before_action :find_instructor, only: %i[show destroy update]
  rescue_from ActiveRecord::RecordNotFound, with: :render_instructor_not_found

  def index
    instructors = Instructor.all
    render json: instructors, status: :ok
  end

  def show
    render json: @instructor, status: :ok
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def destroy
    @instructor.destroy
    head :no_content
  end

  def update
    @instructor.update!(instructor_params)
    render json: @instructor, status: :accepted
  end

  private

  def instructor_params
    params.permit(:name)
  end

  def find_instructor
    @instructor = Instructor.find(params[:id])
    # byebug
  end

  def render_instructor_not_found
    render json: { "error": 'Instructor not found' }, status: :not_found
  end
end
