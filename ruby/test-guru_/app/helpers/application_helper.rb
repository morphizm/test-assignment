module ApplicationHelper
  def year
    Time.current.year
  end

  def link_to_github(author, repo)
    "https://github.com/#{author}/#{repo}"
  end
end
