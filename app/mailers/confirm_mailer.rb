class ConfirmMailer < ApplicationMailer
  default from: "night1300013@hotmail.com"

  def confirm_mail(user)

     headers["Message-ID"] = "<#{user.email}@limitless-plains-98135.herokuapp.com>"
     headers["In-Reply-To"] = "<#{user.email}@limitless-plains-98135.herokuapp.com>"
     headers["References"] = "<#{user.email}@limitless-plains-98135.herokuapp.com>"

     @user = user

     mail(to: user.email, subject: "Thanks for signing up")
   end
end
