module JsonResponseHelpers
  def json_response
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
  end

  def json_data
    json_response[:data]
  end

  def json_errors
    json_response[:errors] || json_response[:error]
  end

  def json_meta
    json_response[:meta]
  end

  def expect_json_response(status)
    expect(response).to have_http_status(status)
    expect(response.content_type).to include('application/json')
  end
end