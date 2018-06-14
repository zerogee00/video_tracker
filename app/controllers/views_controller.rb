class ViewsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def index
    if params[:video_id]
      result = View.where(video_id: params[:video_id])
    else
      result = View.all
    end
    render json: result
  end

  def create
    viewed_at = params[:viewed_at]
    if viewed_at
      begin
        Time.parse(viewed_at)
        video = Video.find(params[:video_id]) rescue ActiveRecord::RecordNotFound
        if video == ActiveRecord::RecordNotFound 
          result, status = not_found_error(params[:video_id]
        )
        else
          result = View.create(video_id: params[:video_id], viewed_at: viewed_at)
        end
      rescue ArgumentError=> error
        result, status = malformed_parameter_error('viewed_at',
          error.message.gsub('"', "'")
        )
      end
    else
      video = Video.find(params[:video_id]) rescue ActiveRecord::RecordNotFound
      if video == ActiveRecord::RecordNotFound
          result, status = not_found_error(params[:video_id]
        )
      else
        result = View.create(video_id: params[:video_id], viewed_at: Time.now)
      end  
    end
    render json: result, status: status
  end

  def malformed_parameter_error( attribute, requirement )
    [ {
      'error': 'malformed_parameter_error', 
      'message': 'One or more required parameters are malformed.',
      'parameter': attribute,
      'requirement': requirement
    },
     403 ]
  end

  def not_found_error( attribute )
    [ {
      'error': 'not_found_error', 
      'message': 'The item was not found.',
      'video_id': attribute
    },
     404 ]
  end
end