class Api::V1::AppointmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @appointments = Appointment.includes(:furniture).where(user_id: params[:user_id])
    render json: @appointments
  end

  def new
    @appointment = Appointment.new
  end

  def show
    Appointment.find(params[:id])
    render json: appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: { status: 'Success', message: 'Appointment created successfully' }, status: :created
    else
      render json: { error: 'Unable to create appointment.' }, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment = Appointment.find_by(id: params[:id])
    if @appointment
      if @appointment.destroy
        render json: { message: 'Appointment deleted successfully.' }
      else
        render json: { error: 'Unable to delete appointment.' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Appointment not found.' }, status: :not_found
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appoint_date, :furniture_id, :city, :user_id)
  end
end
