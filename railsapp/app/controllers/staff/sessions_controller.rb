class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_members = StaffMember.find_by("email = ?", @form.email.downcase)
    end
    if staff_members
      session[:staff_member_id] = staff_members.id
      redirect_to :staff_root
    else
      render action: 'new'
    end
  end

  def destroy
    # if current_staff_member
    #   current_staff_member.events.create!(type: "logged_out")
    # end
    session.delete(:staff_member_id)
    # flash.notice = "ログアウトしました。"
    puts "Redirecting to: #{staff_root_path}"
    redirect_to :staff_root
  end
end
