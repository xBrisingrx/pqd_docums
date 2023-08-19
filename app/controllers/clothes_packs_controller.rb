class ClothesPacksController < ApplicationController

	def disable
    clothe = ClothesPack.find(params[:clothes_pack_id])
    activity_history = ActivityHistory.new( action: :disable, description: "El usuario #{Current.user.username} elimino la ropa #{clothe.clothe.name} del pack #{clothe.clothing_package.name}", 
      record: clothe, date: Time.now, user: Current.user )
    if clothe.destroy && activity_history.save
      render json: { status: 'success', msg: 'Ropa eliminada', id: params[:clothes_pack_id] }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

end
