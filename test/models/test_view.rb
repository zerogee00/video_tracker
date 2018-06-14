require 'test_helper'
 
class TestView < ActiveSupport::TestCase

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

  test "should create valid video for views testing" do
    assert @valid_video.valid?, "Valid video should have been created."
  end

  test "that views can be created" do
    view = View.create(
      video_id: @valid_video.id,
      viewed_at: "#{@random_date}"
    )
    assert view.valid?, "view was unable to save."
  end

  test "validates video_id" do
    view = View.new(
      viewed_at: "#{@random_date}"
    )
    assert_not view.valid?, 'missing video_id should not be valid'
  end

  test "validates viewed_at" do
    view = View.new(
      video_id: 1
    )
    assert_not view.valid?, 'missing viewed_at timestamp should not be valid'
  end

end