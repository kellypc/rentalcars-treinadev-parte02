class Api::V1::CarsController < Api::V1::ApiController
  def show
    #begin
      @car = Car.find(params[:id])

      render json: @car, status: :ok
    #rescue ActiveRecord::RecordNotFound
    #  render status: :not_found, json:'error'
  end

  def create
    if params[:car].nil?
      render json: 'Object not found', status: 412 
    else
      @car = Car.new(params.require(:car).permit(:car_km, :license_plate, :color,
                                                :car_model_id, :subsidiary_id))
        if @car.valid?
          save!
          render json: @car
        end
    end
  end
end