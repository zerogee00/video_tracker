require 'test_helper'
class TestVideosController < ActionDispatch::IntegrationTest
  
  setup do
    WebMock.allow_net_connect!
    @valid_video = Video.create(
      name: 'Test Video',
      brand: 'Test Brand',
      published_at: Time.now
    )
    WebMock.disable_net_connect!

    @random_date = Time.at(rand * Time.now.to_i)
    
  end

  test "should create valid video for views controller testing" do
    assert @valid_video.valid?, "Valid video should have been created."
  end

  test "should get views" do
    get '/views'
    assert_response :success
  end

  test "should get views for specific video" do
    get "/views?video_id=#{@valid_video.id}"
    assert_response :success
  end

  test "should write a view for a specific video" do
    post "/videos/#{@valid_video.id}/views", params: {viewed_at: "#{@random_date}"}, as: :json
    assert_response :success
  end

  test "should return 403 when trying to write view with malformed time" do
    post "/videos/#{@valid_video.id}/views", params: {viewed_at: 'not_a_time'}, as: :json
    assert_response :forbidden
  end

  test "should should return 404 when trying to create a view for a video that does not exist" do
    post '/videos/99999999999/views'
    assert_response :not_found
  end

end