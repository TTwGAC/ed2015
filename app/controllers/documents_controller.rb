class DocumentsController < ApplicationController
  before_filter :authenticate_player!
  before_filter do
    params[:document] &&= document_params
  end

  load_and_authorize_resource

  # GET /documents
  # GET /documents.json
  def index
    if @documentable = find_documentable
      @documents = @documentable.documents
    else
      @documents = Document.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/new
  # GET /documents/new.json
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.json
  def create
    @documentable = find_documentable
    @document = @documentable.documents.build(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @documentable, flash: { success: 'Document was successfully created.' } }
        format.json { render json: @document, status: :created, location: @document }
      else
        format.html { render action: "new" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    @document = Document.find(params[:id])
    documentable = @document.documentable

    respond_to do |format|
      if @document.update_attributes(document_params)
        format.html { redirect_to documentable, flash: { success: 'Document was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document = Document.find(params[:id])
    documentable = @document.documentable
    if @document.destroy
      flash[:notice] = "Deleted \"#{@document.name}\""
    else
      flash[:error] = "Error deleting document"
    end

    respond_to do |format|
      format.html { redirect_to documentable }
      format.json { head :no_content }
    end
  end

private

  # Use this method to whitelist the permissible parameters. Example:
  # params.require(:person).permit(:name, :age)
  # Also, you can specialize this method with per-user checking of permissible attributes.
  def document_params
    params.require(:document).permit(:description, :name, :private, :file)
  end

  def find_documentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
