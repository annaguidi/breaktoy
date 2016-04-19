class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    # @group.member.user = current_user
    if @group.save
      flash[:notice] = "Group added successfully!"
      redirect_to "/"
    else
      flash[:error] = "Group not added successfully! #{@group.errors.full_messages.join ', '}."
      render :new
    end
  end

end
