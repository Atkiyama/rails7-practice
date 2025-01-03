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
  Rails.logger.info "Logged in"
  @form = Staff::LoginForm.new(params[:staff_login_form])
  Rails.logger.info "フォームの初期化完了"
  
  if @form.email.present?
    staff_member = StaffMember.find_by("email = ?", @form.email.downcase)
  end
  Rails.logger.info "スタッフメンバーの検索完了"
  
  if staff_member && Staff::Authenticator.new(staff_member).authenticate(@form.password)
    if staff_member.suspended?
      Rails.logger.info "アカウント停止"
      flash.now.alert = "アカウントが停止されています。"
      render action: "new"
    else
      Rails.logger.info "ログインしました"
      session[:staff_member_id] = staff_member.id
      flash.notice = "ログインしました。"
      redirect_to :staff_root
    end
  else
    Rails.logger.info "存在しない"
    flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
    render action: 'new'
  end
end

  def destroy
    # if current_staff_member
    #   current_staff_member.events.create!(type: "logged_out")
    # end
    session.delete(:staff_member_id)
    # flash.notice = "ログアウトしました。"
    Rails.logger.info "Logged out"
    redirect_to :staff_root
  end
end
