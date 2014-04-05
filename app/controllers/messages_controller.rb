class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /messages
  def index
    @messages = Message.all
  end

  # GET /messages/1
  def show
  end

  def get_destinations
    everyone = OpenStruct.new name: "Everyone", id: :everyone, class: 'Everyone'
    @destinations = []
    @destinations << ["Everyone", [everyone]]
    @destinations << ["Teams", Team.playing]
    @destinations << ["Players", Player.select(&:playing?)]
  end

  # GET /messages/new
  def new
    @message = Message.new
    get_destinations
  end

  # GET /messages/1/edit
  def edit
    unless @message.sendable?
      redirect_to messages_url, notice: 'Sent messages are not editable'
    end
    get_destinations
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @message.sender = current_player

    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      get_destinations
      render action: 'new'
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params.merge(sender: current_player))
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def send_message
    @message = Message.find(params[:message_id])
    unless @message.sendable?
      case @message.delivery_type
      when 'sms'
        raise 'TODO'
        TropoBlaster.new mode: 'sms'
      when 'phone'
        raise 'TODO'
        TropoBlaster.new mode: 'voice'
      when 'email'
        @message.targets.each do |player|
          delivery = MessageDelivery.create destination: player.email, message: @message, player: player, status: 'queued'
          mailer = MessagingMailer.burdell_broadcast player.email, @message.text
          mailer.deliver
          delivery.status = 'sent'
          delivery.save!
        end
      end
      @message.update status: 'sent'
      redirect_to @message
    else
      redirect_to @message, alert: "This message has already been sent."
    end
  end

  # DELETE /messages/1
  def destroy
    if @message.status == 'sent'
      redirect_to messages_url, alert: 'Sent messages may not be deleted'
    else
      @message.destroy
      redirect_to messages_url, notice: 'Message was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params[:message].permit(:delivery_type, :destination, :text)
    end
end
