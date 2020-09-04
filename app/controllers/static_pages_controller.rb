class StaticPagesController < ApplicationController
    require 'flickr'

    def index
        if params[:user_id].present?
            @flickr = Flickr.new
            @public_photos = @flickr.people.getPublicPhotos(api_key: ENV['FLICKR_API_KEY'], user_id: params[:user_id])
            @photo_ids = @public_photos.map do |photo|
                photo['id']
            end
            @photo_urls = @photo_ids.map do |photo|
                @flickr.photos.getSizes(api_key: ENV['FLICKR_API_KEY'], photo_id: photo)[6]['source']
            end
        end
    end

end
