class Admin::QuestionsController < Admin::BaseController

  before_action :find_question, only: [:destroy, :edit, :show, :update]
  before_action :find_test, only: [:new, :create]

  rescue_from ActiveRecord::RecordInvalid, with: :rescue_with_question_created
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def new
    @question = @test.questions.new
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to [:admin, @question]
    else
      render :edit
    end
  end

  def show
    @test = @question.test
  end

  def destroy
    @question.destroy
    redirect_to [:admin, @question.test]
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found(err)
    render plain: "Question not found, #{err}"
  end

  def rescue_with_question_created(err)
    render plain: err.message
  end

  def question_params
    params.require(:question).permit(:title)
  end
end
