require 'flickr'

class StaticPagesController < ApplicationController
  def home 
    flickr = Flickr.new Figaro.env.key, Figaro.env.secret
    unless params[:user_id].nil?
      begin
        Rails.logger.info("User id: #{params[:user_id]}")

        responses = flickr.photos.search(user_id: params[:user_id])
        @photos = responses.map do |rsp|
          "https://live.staticflickr.com/#{rsp.server}/#{rsp.id}_#{rsp.secret}.jpg"
        end
      rescue => e
        flash[:alert] = e.message
      end
    end

  end
  
end
