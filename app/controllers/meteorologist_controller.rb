require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    @readable_street_address = @street_address.gsub(" ", "+")
    @address_url = "https://maps.googleapis.com/maps/api/geocode/json?address="+@readable_street_address

    @parsed_data_address = JSON.parse(open(@address_url).read)

    @latitude = @parsed_data_address["results"][0]["geometry"]["location"]["lat"]

    @longitude = @parsed_data_address["results"][0]["geometry"]["location"]["lng"]

    @weather_url = "https://api.darksky.net/forecast/b050473b67c23d6057c6c55a157cf68c/"+@latitude.to_s+","+@longitude.to_s

    @parsed_data = JSON.parse(open(@weather_url).read)

    @current_temperature = @parsed_data["currently"]["temperature"]

    @current_summary = @parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_data["daily"]["summary"]



    render("meteorologist/street_to_weather.html.erb")
  end
end
