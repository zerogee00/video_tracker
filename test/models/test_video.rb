require 'test_helper'
 
class TestVideo < ActiveSupport::TestCase

  setup do
    @random_date = Time.at(rand * Time.now.to_i)
  end

  test "that videos can be created" do
    video = Video.new(
      name: 'Test Video',
      brand: 'Test Brand',
      published_at: "#{@random_date}"
    )
    assert video.valid?, 'Video was unable to save.'
  end

  test "validates name" do
    video = Video.new(
      brand: "Test Brand",
      published_at: "#{@random_date}"
    )
    assert_not video.valid?, 'missing name should not be valid'
  end

  test "validates brand" do
    video = Video.new(
      name: "Test Video",
      published_at: "#{@random_date}"
    )
    assert_not video.valid?, 'missing brand should not be valid'
  end

  test "validates published_at" do
    video = Video.new(
      name: "Test Video",
      brand: "Test Brand"
    )
    assert_not video.valid?, 'missing published_at timestamp should not be valid'
  end

end