class GistQuestionService
  def initialize(question, client = default_client)
    @question = question
    @test = @question.test
    @client = client
  end

  def call
    gist = @client.create_gist(gist_params)
    Struct.new('Result', :success?, :html_url)
    Struct::Result.new(!gist.html_url.nil?, gist.html_url)
  end

  private

  def gist_params
    {
      description: I18n.t('services.gist_question.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.title]
    content += @question.answers.pluck(:title)
    content.join("\n")
  end

  def default_client
    GitHubClient.new
  end
end
