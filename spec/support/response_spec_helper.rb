# frozen_string_literal: true

module ResponseSpecHelper
  def json
    JSON.parse(response.body)
  end
end
