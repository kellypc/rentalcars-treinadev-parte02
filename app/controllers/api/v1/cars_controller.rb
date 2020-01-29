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
          @car.save!
          render json: @car
        else
          render json: {"message": @car.errors.full_messages}, status: 412
        end
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    render json: {"message": "Carro excluido com sucesso"}
  end
end