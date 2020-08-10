class Admin::TestsController < Admin::BaseController
  before_action :set_tests, only: [:index, :update_inline]
  before_action :find_test, only: [:show, :destroy, :update, :edit, :update_inline]

  def index; end

  def show; end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test]
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    @test.author = current_user
    if @test.save
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def set_tests
    @tests = Test.all
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :timer)
  end
end
