class MtaController < ApplicationController

  def index # this is just for display; this seemingly empty function is not empty: it renders the index view
  end

  def create # this is something we already got; you can see in rake routes; here you can get native params!
    @number_of_stations = number_of_stations params[:start_line].to_sym, params[:start_station], params[:end_line].to_sym, params[:end_station]
    render :index # oh....
  end

  def number_of_stations start_train, stop_a, stop_train, stop_b
    mta = {
      n: ['ts', '34th', '28th-n', '23rd-n', 'us', '8th'],
      l: ['8th', '6th', 'us', '3rd', '1st'],
      s: ['gc', '33rd', '28th-s', '23rd-s', 'us', 'ap']
    }

    intersection = (mta[start_train] & mta[stop_train]).first # & gives you the intersection of two arrays, not && as in AND!
    if start_train != stop_train
      stop_a_index = mta[start_train].index(stop_a)
      stop_a_intersection_index = mta[start_train].index(intersection)
      trip_a_length = (stop_a_index - stop_a_intersection_index).abs

      stop_b_index = mta[stop_train].index(stop_b)
      stop_b_intersection_index = mta[stop_train].index(intersection)
      trip_b_length = (stop_b_index - stop_b_intersection_index).abs
      return length_of_trip = trip_a_length + trip_b_length
    else
      stop_a_index = mta[start_train].index(stop_a)
      stop_b_index = mta[stop_train].index(stop_b)
      puts stop_a_index
      puts stop_b_index
      return length_of_trip = (stop_a_index - stop_b_index).abs
    end
  end

end
