class FsFocusItemsController < ApplicationController
  before_action :set_fs_focus_item, only: [:show, :edit, :update, :destroy]
  before_action :set_names, only: [:new]
  before_action :set_descriptions, only: [:new]

  # GET /fs_focus_items
  def index
    if user_signed_in? && current_user.focus_items
      if current_user.focus_items_role == 'Admin'
        @fs_focus_items = FsFocusItem.all
      elsif current_user.focus_items_role == 'Manager'
        @fs_focus_items = FsFocusItem.where(team: current_user.focus_items_manager)
      else
        # must be a rep
        @fs_focus_items = FsFocusItem.where(rep: current_user.email)
      end
    else
      redirect_to signout_path and return
    end
  end

  # GET /fs_focus_items/1
  def show
  end

  # GET /fs_focus_items/new
  def new
    @default_date = Time.current.strftime('%Y-%m-%d')
  end

  # GET /fs_focus_items/1/edit
  def edit
  end

  # POST /fs_focus_items
  def create
    @fs_focus_item = FsFocusItem.new(fs_focus_item_params)

    respond_to do |format|
      if @fs_focus_item.save
        format.html { redirect_to @fs_focus_item, notice: 'Focus item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /fs_focus_items/1
  def update
    respond_to do |format|
      if @fs_focus_item.update(fs_focus_item_params)
        format.html { redirect_to @fs_focus_item, notice: 'Focus item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /fs_focus_items/1
  def destroy
    @fs_focus_item.destroy
    respond_to do |format|
      format.html { redirect_to fs_focus_items_url, notice: 'Focus item was successfully deleted.' }
    end
  end

  def selected
    data_changed = false
    params[:name].each do |d|
      if !d.empty?
        data_changed = true
        p = Partmstr.find_by(part_desc: params[:part])
        if current_user.focus_items_role == "Admin"
          # Apply changes to all customers for all reps of selected managers
          e = Employee.find_by(Employee_Name: d)
          rep_array = User.where(focus_items_manager: e.Badge_)
          rep_array.each do |r|
            # get all customers for this rep
            shiptos = []
            if r.focus_items_rep1
              shiptos = CustomerShipto.where(acct_manager: r.focus_items_rep1)
              if r.focus_items_rep2
                shiptos2 = CustomerShipto.where(acct_manager: r.focus_items_rep2)
                shiptos += shiptos2
              end
            end
            shiptos.each do |s|
              FsFocusItem.where(customer: s.shipto_code, part_desc: params[:part]).first_or_initialize.tap do |f|
                f.start_date = params[:start_date]
                f.end_date = params[:end_date]
                f.team = r.focus_items_manager
                f.rep = r.email
                f.part_code = p.part_code
                f.save
              end
            end
          end
        elsif current_user.focus_items_role == "Manager"
          # Apply changes to all customers for all selected reps
          e = Employee.find_by(Employee_Name: d)
          r = User.find_by(email: e.Badge_)
          # get all customers for this rep
          shiptos = []
          if r.focus_items_rep1
            shiptos = CustomerShipto.where(acct_manager: r.focus_items_rep1)
            if r.focus_items_rep2
              shiptos2 = CustomerShipto.where(acct_manager: r.focus_items_rep2)
              shiptos += shiptos2
            end
          end
          shiptos.each do |s|
            FsFocusItem.where(customer: s.shipto_code, part_desc: params[:part]).first_or_initialize.tap do |f|
              f.start_date = params[:start_date]
              f.end_date = params[:end_date]
              f.team = r.focus_items_manager
              f.rep = e.Badge_
              f.part_code = p.part_code
              f.save
            end
          end
        else
          # Apply changes to all selected customers
          # if present the shipto_code should be in the second field of the name
          if d.include? '*'
            field_array = d.split('*')
            shipto = field_array[1]
          else
            # no shipto code in the name so look it up, the cust_code is the shipto_code in this case
            s = CustomerShipto.find_by bus_name: d
            shipto = s.cust_code
          end
          FsFocusItem.where(customer: shipto, part_desc: params[:part]).first_or_initialize.tap do |f|
            f.start_date = params[:start_date]
            f.end_date = params[:end_date]
            f.team = current_user.focus_items_manager
            f.rep = current_user.email
            f.part_code = p.part_code
            f.save
          end
        end
      end
    end
    if data_changed
      redirect_to fs_focus_items_path, notice: 'Focus items were successfully created.'
    else
      redirect_to fs_focus_items_path, notice: 'No Focus items were created.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fs_focus_item
      @fs_focus_item = FsFocusItem.find(params[:id])
    end

    def set_names
      sort_array = []
      @names = []
      @role = current_user.focus_items_role
      if @role == "Admin"
        manager_array = User.where(focus_items_role: "Manager")
        manager_array.each do |m|
          e = Employee.find_by(Badge_: m.email)
          sort_array.push(e.Employee_Name)
        end
      elsif @role == "Manager"
        rep_array = User.where(focus_items_manager: current_user.email)
        rep_array.each do |r|
          e = Employee.find_by(Badge_: r.email)
          sort_array.push(e.Employee_Name)
        end
      else
        # this is a rep
        shiptos = []
        if current_user.focus_items_rep1
          shiptos = CustomerShipto.where(acct_manager: current_user.focus_items_rep1)
          if current_user.focus_items_rep2
            shiptos2 = CustomerShipto.where(acct_manager: current_user.focus_items_rep2)
            shiptos += shiptos2
          end
        end
        shiptos.each do |s|
          # build an array of business names
          if s.cust_code == s.shipto_code
            bus_names = CustomerShipto.where(bus_name: s.bus_name)
            if bus_names.length > 1
              # duplicate business names for different customer codes
              sort_array.push(s.bus_name+'*'+s.shipto_code)
            else
              sort_array.push(s.bus_name)
            end
          else
            sort_array.push(s.bus_name+'*'+s.shipto_code)
          end
        end
      end
      @names = sort_array.sort!
    end

    def set_descriptions
      if !$descs
        # need to set up global list of part descriptions
        parts = Partmstr.all
        # parts = Partmstr.where(part_status: 'A')
        sort_array = []
        $descs = []
        $jsdescs = []
        food_parts = ["DRY", "FRE", "FRZ", "MUS"]
        unwanted_uom = ["ST", "LB"]
        parts.each do |p|
          if !p.part_code.blank? && !p.part_desc.start_with?("INACTIVE") && food_parts.include?(p.storage_type) &&
            p.part_status == "A" && !unwanted_uom.include?(p.uom) && p.part_type != "SUPL" && !p.part_desc.start_with?("TRUCK")
            desc = p.part_desc
            if p.part_code[0,1] == 'Z'
              # frozen codes should sort to the bottom of the list
              desc.insert(0,'Z')
            end
            sort_array.push(desc)
          end
        end
        sorted_array = sort_array.sort
        sorted_array.each do |p|
          if p[0,1] == 'Z'
            p = p[1..-1]
          end
          $descs.push(p)
          desc = p.gsub(' ', '~')
          $jsdescs.push(desc)
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def fs_focus_item_params
      params.require(:fs_focus_item).permit(:team, :rep, :customer, :part_code, :part_desc, :start_date, :end_date)
    end
end
