class StudentsController < ApplicationController
  before_action :find_student, only: %i[show destroy update]
  rescue_from ActiveRecord::RecordNotFound, with: :render_student_not_found
  def index
    students = Student.all
    render json: students, status: :ok
  end

  def show
    render json: @student, status: :ok
  end

  def create
    student = Student.create!(student_params)
    render json: student, status: :created
  end

  def destroy
    @student.destroy
    head :no_content
  end

  def update
    @student.update!(student_params)
    render json: @student, status: :accepted
  end

  private

  def student_params
    params.permit(:name, :age, :major, :instructor_id)
  end

  def find_student
    @student = Student.find(params[:id])
  end

  def render_student_not_found
    render json: { "error": 'Student not found' }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end
end
