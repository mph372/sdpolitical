class ItemizedExpendituresController < ApplicationController
  before_action :set_itemized_expenditure, only: [:show, :edit, :update, :destroy]

  # GET /itemized_expenditures
  # GET /itemized_expenditures.json
  def index
    @itemized_expenditures = ItemizedExpenditure.all
  end

  # GET /itemized_expenditures/1
  # GET /itemized_expenditures/1.json
  def show
  end

  # GET /itemized_expenditures/new
  def new
    @itemized_expenditure = ItemizedExpenditure.new
  end

  # GET /itemized_expenditures/1/edit
  def edit
  end

  # POST /itemized_expenditures
  # POST /itemized_expenditures.json
  def create
    @itemized_expenditure = ItemizedExpenditure.new(itemized_expenditure_params)
    @itemized_expenditure.set_campaign
    respond_to do |format|
      if @itemized_expenditure.save
        format.html { redirect_to @itemized_expenditure, notice: 'Itemized expenditure was successfully created.' }
        format.json { render :show, status: :created, location: @itemized_expenditure }
      else
        format.html { render :new }
        format.json { render json: @itemized_expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itemized_expenditures/1
  # PATCH/PUT /itemized_expenditures/1.json
  def update
    respond_to do |format|
      if @itemized_expenditure.update(itemized_expenditure_params)
        format.html { redirect_to @itemized_expenditure, notice: 'Itemized expenditure was successfully updated.' }
        format.json { render :show, status: :ok, location: @itemized_expenditure }
      else
        format.html { render :edit }
        format.json { render json: @itemized_expenditure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itemized_expenditures/1
  # DELETE /itemized_expenditures/1.json
  def destroy
    @itemized_expenditure.destroy
    respond_to do |format|
      format.html { redirect_to itemized_expenditures_url, notice: 'Itemized expenditure was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_itemized_expenditure
      @itemized_expenditure = ItemizedExpenditure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def itemized_expenditure_params
      params.require(:itemized_expenditure).permit(:expenditure_id, :date, :description, :amount)
    end
end
