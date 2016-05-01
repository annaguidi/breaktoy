class GroupsController < ApplicationController

  def index
    @relevant_groups = []
    @groups = Group.all
    @groups.each do |group|
      group.members.each do |member|
        if member.user == current_user
          @relevant_groups << member.group
        end
      end
    end
  end

  def show
    @group = Group.find(params[:id])
    @members = @group.members.map { |member| member.user }
    @invites = Invite.where(group: @group)
    @invited = @invites.map { |invite| invite.user }
    @user_selects = User.all - @members - @invited
    @invite = Invite.new
    if member?(@group) == true
      render :show
    else
      flash[:notice] = "You do not have permission to view these details"
      redirect_to "/"
    end
  end

  def markers
    @id = params[:group_id]
    @group = Group.find(@id)
    @members = @group.members
    # @markers = Marker.all
    @markers = Marker.where(member: @members)
    render json: @markers
  end

  def updatemarkers
    @marker =  Marker.find(params[:id])
    @marker.title = params[:title]
    @marker.description = params[:description]
    @marker.save
    render json: @marker
  end

  def deletemarker
    @marker = Marker.find(params[:id])
    @marker.destroy
    render json: "Marker removed!"
  end

  def updatemarkerposition
    @marker = Marker.find(params[:id])
    @marker.longitude = params[:longitude]
    @marker.latitude = params[:latitude]
    @marker.save
    render json: @marker
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @member = Member.new(user: current_user, group: @group, owner: true)
    if @group.save && @member.save
      flash[:notice] = "Group added successfully!"
      redirect_to group_path(@group)
    else
      flash[:error] = "Group not added successfully! #{@group.errors.full_messages.join ', '}."
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    if member?(@group) == true
      render :edit
    else
      flash[:notice] = "You do not have permission to edit these details"
      redirect_to "/"
    end
  end

  def update
    @group = Group.find(params[:id])

    if owner?(@group) == true
      if @group.update(group_params)
        flash[:notice] = "You just updated your Group Info!"
        redirect_to group_path(@group)
      else
        flash[:error] = "Did not update Group. #{@profile.errors.full_messages.join(', ')}."
        render :edit
      end
    else
      flash[:notice] = "You do not have permission to change this group"
      redirect_to "/"
    end
  end

  def destroy
    @group = Group.find(params[:id])

    if owner?(@group) == true
      if @group.destroy
        flash[:notice] = "Group Deleted Successfully"
        redirect_to groups_path
      else
        flash[:notice] = "You do not have permission to delete this group"
        redirect_to group_path(@group)
      end
    else
      flash[:notice] = "You do not have permission to delete this group"
      redirect_to group_path(@group)
    end
  end

  private

  def group_params
    params.require(:group).permit(
      :name,
      :city,
      :state,
      :country
    )
  end

  def member?(group)
    group.members.each do |member|
      if member.user == current_user
        return true
      end
    end
  end

  def owner?(group)
    group.members.each do |member|
      if member.user == current_user && member.owner == true
        return true
      end
    end
  end
end
