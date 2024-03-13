class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  def create

    @message = Message.create(message_params)

    #ou seja, isso aqui sao os dados do backend que são enviados la pro js no metodo received(data)
    #o data esta recebendo @message

    #essa logica poderia estar na model, por exemplo em um callback after_create_commit, por exemplo
    ActionCable.server.broadcast("the_chat", @message)
    head :ok


    
    #isso aqui sao exemplos de como eu poderia chamar o action cable
    #@universidades = Universidade.all
    #@count_universidades = Universidade.all.count
       
    #ActionCable.server.broadcast "the_chat", 
    #universidades: @universidades        #esses parametros sao recebios no metodo received(universidades, contagem)
    #contagem: @count_universidades
   
  end

  # POST /messages or /messages.json
  def create02
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content)
    end
end
