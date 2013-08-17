class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.json
  def index
    @message = Message.new
    @user = current_user || User.new
    @messages = Message.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def portal
    @user = User.find(params[:id]) || User.new
    @messages = @user.messages.order('created_at DESC')
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.json
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    if params[:message].class == String
      @message = Message.new
      @message.content = params[:message]
      @message.user = current_user
    else
      @message = Message.new(params[:message])
      @message.user = current_user
    end

    respond_to do |format|
      if @message.save
        format.html { redirect_to root_url, notice: '成功发布一条微博！' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: '成功修改了微博内容' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, alert: '刚刚删除了一条微博内容' }
      format.json { head :no_content }
    end
  end
end
