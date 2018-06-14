class VideosController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create, :update]

  def index
    render json: Video.all
  end

  def show
    begin
      video = Video.find(params[:id]) rescue ActiveRecord::RecordNotFound
      if video == ActiveRecord::RecordNotFound
        result, status = not_found_error(params[:id]
      )
      else
        case
        when params[:view_count]
          result = video.views.count
        when params[:views_on_date]
          start_date = Date.parse(params[:views_on_date])
          sql_string = "TO_CHAR(viewed_at::timestamp, 'YYYY-MM-DD') ILIKE '%#{start_date}%'"
          result = video.views.where(sql_string).count
        when params[:views_from_date]
          start_date = Date.parse(params[:views_from_date])
          result = video.views.where(:viewed_at => start_date..Date.today).count
        else
          result = video
        end
      end
    rescue ArgumentError
      result, status = malformed_parameter_error(params[:published_at],
        'Should be a timestamp' 
      )
    end

    if result.is_a?( Integer )
     body = { 
        'video': video,
        'view count': result
        }
    elsif result[:message]
      body = result
    else
       body = { 
        'video': video
      }
    end

    render json: body, status: status  
  end

  def create
    if params[:name] && params[:brand] && params[:published_at]
      begin
        Time.parse(params[:published_at])
        result = Video.create(
          name: params[:name],
          brand: params[:brand],
          published_at: params[:published_at]
        )
      rescue ArgumentError => error
        result, status = malformed_parameter_error('published_at',
          error.message.gsub('"', "'")
        )
      end
    else
      result, status = missing_parameter_error
    end
    render json: result, status: status
  end

  def update
    result = Video.find(params[:id])
    if params[:published_at]
      begin
        Time.parse(params[:published_at])
        result.update(params[:video].permit(:name, :brand, :published_at))
      rescue ArgumentError => error
        result, status = malformed_parameter_error('published_at',
          error.message.gsub('"', "'")
        )
      end
    else
      result.update(params[:video].permit(:name, :brand))
    end  
    render json: result, status: status
  end

  def missing_parameter_error
    [ {
      'error': 'missing_parameter_error', 
      'message': 'One or more required parameters are missing.',
      'required parameters': Video.validators.map(&:attributes).flatten
    },
     422 ]
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