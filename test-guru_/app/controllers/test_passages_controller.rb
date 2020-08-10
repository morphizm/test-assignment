class TestPassagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def update
    @test_passage.accept!(params[:answer_ids])
    if @test_passage.completed?
      badges = BadgeService.new(@test_passage).badges
      current_user.badges << badges if badges
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def show; end

  def result; end

  def gist
    question = @test_passage.current_question
    result = GistQuestionService.new(question).call
    if result.success?
      html_url = result['html_url']
      Gist.create(question: question, user: current_user, url: html_url)
      flash[:notice] = view_context.link_to(t('.success'), html_url, target: "_blank")
    else
      flash[:alert] = t('.failure')
    end
    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
