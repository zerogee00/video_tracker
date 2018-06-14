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

  test "should create valid video for videos controller testing" do
    assert @valid_video.valid?, "Valid video should have been created."
  end

  test "should get videos" do
    get '/videos'
    assert_response :success
  end

  test "should get a specific video" do
    get "/videos/#{@valid_video.id}"
    assert_response :success
  end

  test "should get a view count specific video" do
    get "/videos/#{@valid_video.id}?view_count=true"
    assert_response :success
  end

  test "should get a view count specific video on a specific date" do
    get "/videos/#{@valid_video.id}?views_on_date=#{@random_date}"
    assert_response :success
  end

  test "should get a view count specific video from a specific date" do
    get "/videos/#{@valid_video.id}?views_from_date=#{@random_date}"
    assert_response :success
  end

  test "should write videos" do
    post '/videos', params: {name: "Test Video", brand: 'Test Brand', published_at: "#{@random_date}"}, as: :json
    assert_response :success
  end

  test 'should update a specific video' do
    patch "/videos/#{@valid_video.id}", params: {video: {name: "New Test Video"}}
    assert_response :success
  end

  test "should return 403 when trying to write video with malformed time" do
    post "/videos", params: {name: "Test Video", brand: 'Test Brand', published_at: 'not_a_time'}, as: :json
    assert_response :forbidden
  end

  test "should should return 404 when trying to get a video that does not exist" do
    get '/videos/99999999999'
    assert_response :not_found
  end

  test "should return 422 when trying to write videos with missing name" do
    post '/videos', params: {brand: 'Test Brand', published_at: "#{@random_date}"}, as: :json
    assert_response 422
  end

  test "should should return 422 when trying to write videos with missing brand" do
    post '/videos', params: {name: "Test Video", published_at: "#{@random_date}"}, as: :json
    assert_response 422
  end

  test "should should return 422 when trying to write videos with missing published_at timestamp" do
    post '/videos', params: {name: "Test Video", brand: 'Test Brand'}, as: :json
    assert_response 422
  end
end