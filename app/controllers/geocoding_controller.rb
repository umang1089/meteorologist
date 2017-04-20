require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

@readable_street_address = @street_address.gsub(" ", "+")
@url = "https://maps.googleapis.com/maps/api/geocode/json?address="+@readable_street_address

@parsed_data = JSON.parse(open(@url).read)
@lat = @parsed_data["results"][0]["geometry"]["location"]["lat"]
@lng= @parsed_data["results"][0]["geometry"]["location"]["lng"]

    @latitude = @lat

    @longitude = @lng

    render("geocoding/street_to_coords.html.erb")
  end
end
