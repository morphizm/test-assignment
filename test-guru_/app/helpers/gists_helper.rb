module GistsHelper
  def hash(url)
    result = url.split('/')
    result[-1]
  end
end
